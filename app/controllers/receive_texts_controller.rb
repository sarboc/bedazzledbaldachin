class ReceiveTextsController < ApplicationController

require 'twilio-ruby'

  def index
  #   # let's pretend that we've mapped this action to
  #   # http://localhost:3000/sms in the routes.rb file

  #   # message_body = params["Sms"]
  #   # # from_number = params["From"]

    # SMSLogger.log_text_message from_number, message_body

    @city = params[:FromCity]
    @state = params[:FromState]
    @reply = params[:Body]
    render 'index.xml.erb', :content_type => 'text/xml'

    # let's pretend that we've mapped this action to
    # http://localhost:3000/sms in the routes.rb file

  end

end
