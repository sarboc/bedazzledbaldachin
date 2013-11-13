class EventsController < ApplicationController

# Get twilio-ruby from twilio.com/docs/ruby/install

  def index

  end

  def new
    @event = Event.new
    @party_type_id = params[:party_type_id]
  end

  def create
    @event = Event.create(params[:event])
    redirect_to event_path(@event.id)
  end

  def show
    @id = params[:id]
    @event = Event.find(@id)
    @players = Player.find_by_event_id(@id)
  end

end
