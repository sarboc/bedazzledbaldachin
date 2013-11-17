class EventsController < ApplicationController
  before_filter :authenticate_user!
  require 'twilio-ruby'

  def index
    events = Event.where("user_id = ?", current_user.id)
    @events = events.sort_by { |k| k[:created_at] }.reverse
    @current_event = events.find_by_event_status(true)
  end

  def new
    @event = Event.new
    @party_type_id = params[:party_type_id]
  end

  def create
    @event = Event.create(params[:event])
    party_master = Player.create(name: current_user.name, phone: current_user.phone, event_id: @event.id, accepted: true)
    redirect_to event_path(@event.id)
  end

  def show
    @id = params[:id]
    @event = Event.find(@id)
    @player = Player.new
    @players = @event.players

    respond_to do |format|
      format.html
      format.json {
        render json: @players
      }
    end
  end

  def update
    @id = params[:id]

    @event = Event.find(@id)

    # if a party has never been started
    if @event.start_time == nil
      @event.start

    # if a party has already been started, stop it
    elsif @event.event_status == true
      @event.end
    end

    respond_to do |format|
      format.html {redirect_to events_path}
      format.json {render json: @event}
    end
  end
end
