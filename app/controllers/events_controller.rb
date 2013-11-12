class EventsController < ApplicationController

# Get twilio-ruby from twilio.com/docs/ruby/install
require 'rubygems'          # This line not needed for ruby > 1.8
require 'twilio-ruby'

def index
  account_sid    = ENV["account_sid"]
  auth_token     = ENV["auth_token"]
  @client = Twilio::REST::Client.new account_sid, auth_token

  @account = @client.account
  @message = @account.sms.messages.create({
    :from => '+16018034035',
    :to => '+15103755091',
    :body => 'hey hey das ist mein erster test mit tqilio fuer die bedazzleds'})
  puts @message
end

end
