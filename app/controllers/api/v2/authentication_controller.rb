class Api::V2::AuthenticationController < Api::BaseController

	skip_before_action :authenticate_token!

  def create
    user = User.find_by(email: params[:email])
    if user.valid_password? params[:password]
      render json: { token: JsonWebToken.encode(sub: user.id) }
    else
      render json: { errors: ["Invalid email or password"] }
    end
  end
end
