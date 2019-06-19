class ApplicationController < ActionController::Base
  before_action :basic_auth

  private

  def production?
    Rails.env.production?
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == "free" && passeord == "market"
  end
end
