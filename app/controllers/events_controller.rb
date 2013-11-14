class EventsController < ApplicationController
  before_filter :authenticate_user!
  require 'rubygems'          # This line not needed for ruby > 1.8
  require 'twilio-ruby'
# Get twilio-ruby from twilio.com/docs/ruby/install

  def index

  end

  def new
    @event = Event.new
    @party_type_id = params[:party_type_id]
  end

  def create
    @event = Event.create(params[:event])
    Player.create(name: current_user.name, phone: current_user.phone, event_id: @event.id)
    redirect_to event_path(@event.id)
  end

  def show
    @id = params[:id]
    @event = Event.find(@id)
    @players = @event.players

    respond_to do |format|
      format.html
      format.json {
        render :json => @players
      }
    end
  end

  def update
    @id = params[:id]
    @event = Event.find(@id)
    @event.add_start_end_time
    render :json => @event
  end
end
