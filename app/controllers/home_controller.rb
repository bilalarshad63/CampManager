class HomeController < ApplicationController
  before_action :authenticate_user!
  layout 'user_layout'

  def index; end
end
