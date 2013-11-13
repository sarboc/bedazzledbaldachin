#needs to go in events-controller

class SendTextsController < ApplicationController

require 'rubygems'          # This line not needed for ruby > 1.8
require 'twilio-ruby'



def index

  # number_to_send_to = params[:phone]
  # @receiver_name = params[:name]

  #DO LIKE this in inout-forms!! name="restaurant[town]

  account_sid    = ENV["account_sid"]
  auth_token     = ENV["auth_token"]
  @client = Twilio::REST::Client.new account_sid, auth_token

  @account = @client.account
  @message = @account.sms.messages.create({
    :from => '+16018034035',
    :to => '+15103755091' #number_to_send_to,
    :body => 'Howdie <%= @receiver_name %>: You got an invite from <<partymeistersname:wir brauchen hodden field in der new form hierfuer um den partymeister durchzupassen>> to join a LEDERFEIER! Text back [ACCEPT + YourName] or [DECLINE + YourName]'})
  puts @message

end


end
