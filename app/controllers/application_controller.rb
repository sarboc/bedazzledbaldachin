class ApplicationController < ActionController::Base
  protect_from_forgery
  include EventsHelper
  include TwiliosHelper

  def check_for_mobile
    session[:mobile_override] = params[:mobile] if params[:mobile]
    redirect_to events_path if mobile_device?
  end

  def mobile_device?
    if session[:mobile_override]
      session[:mobile_override] == "1"
    else
      (request.user_agent =~ /Mobile|webOS/)
    end
  end
  helper_method :mobile_device?
end
