class PasswordsController < Devise::PasswordsController
  def create
    self.resource = resource_class.send_reset_password_instructions(resource_params)
    if successfully_sent?(resource)
      render :new
    else
      respond_with(resource)
    end
  end

  def new
    super
  end

  def update
    super
  end

  def edit
    super
  end
end
