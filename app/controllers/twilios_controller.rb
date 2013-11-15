class TwiliosController < ApplicationController

require 'twilio-ruby'

  def index
    @reply = parse_message(params[:From], params[:Body])

    render 'index.xml.erb', :content_type => 'text/xml'
  end
end
