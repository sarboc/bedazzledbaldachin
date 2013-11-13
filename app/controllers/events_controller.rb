class EventsController < ApplicationController

# Get twilio-ruby from twilio.com/docs/ruby/install

  def index

  end

  def new
    @event = Event.new
    @user = User.new
  end

  def create

  end

  def show
  end

end
