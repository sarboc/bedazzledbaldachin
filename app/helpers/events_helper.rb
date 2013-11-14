module EventsHelper

  def send_text(phone, text)
    account_sid    = ENV["account_sid"]
    auth_token     = ENV["auth_token"]
    @client = Twilio::REST::Client.new account_sid, auth_token

    @account = @client.account
    @message = @account.sms.messages.create({
      :from => '+16018034035',
      :to => phone,
      :body => text})
    puts @message
  end

end
