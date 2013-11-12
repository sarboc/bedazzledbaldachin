class SendTextsController < ApplicationController

require 'rubygems'          # This line not needed for ruby > 1.8
require 'twilio-ruby'

def index

  # number_to_send_to = params[:number_to_send_to]

  account_sid    = ENV["account_sid"]
  auth_token     = ENV["auth_token"]
  @client = Twilio::REST::Client.new account_sid, auth_token

  @account = @client.account
  @message = @account.sms.messages.create({
    :from => '+16018034035',
    :to => '+15103755091',
    :body => 'some text'})
  puts @message

end


end
