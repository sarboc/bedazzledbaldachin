class ReceiveTextsController < ApplicationController

require 'twilio-ruby'

  def index
  #   # let's pretend that we've mapped this action to
  #   # http://localhost:3000/sms in the routes.rb file

  #   # message_body = params["Sms"]
  #   # # from_number = params["From"]

    # SMSLogger.log_text_message from_number, message_body
    @phone = params[:From]
    @city = params[:FromCity]
    @state = params[:FromState]
    if params[:Body].include?("ACCEPT" || "accept") #hier muss der name noch mit durchgepasst werden!!
      @reply = "Sweet! You will soon receive some badass lederfeier prompts!"
    elsif params[:Body].include?("DECLINE" || "decline")
      @reply = "That is ok! See you next time!"
    end

    render 'index.xml.erb', :content_type => 'text/xml'


    # let's pretend that we've mapped this action to
    # http://localhost:3000/sms in the routes.rb file


  end

end
