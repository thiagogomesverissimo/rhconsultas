class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_logged
    authenticate_or_request_with_http_basic("index") do |username,password|
      username=="rh" and password=="rh"
    end
  end

end
