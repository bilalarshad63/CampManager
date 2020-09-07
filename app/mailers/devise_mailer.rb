class DeviseMailer < Devise::Mailer
  include AbstractController::Callbacks
  before_action :add_inline_attachment!
  helper EmailHelper
  layout 'email'
  default from: 'te6310@gmail.com'

  private

  def add_inline_attachment!
    image = Rails.root.join('app/assets/images/logo.png')
   # attachments.inline['logo.png'] = File.read(image)
  end
end
