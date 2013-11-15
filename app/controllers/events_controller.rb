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
    if @event.event_status == nil
      @event.start

      party_players = @event.players
      # iterate through players, sending the first prompt to each - the Party Starter!
      party_players.each do |this_player|
        send_text(this_player.phone, this_player.get_new_prompt)
      end

    # if a party has already been started, stop it
    elsif @event.event_status == true
      @event.end

    # if a party has been stopped, restart it
    elsif @event.event_status == false
      @event.start
    end

    render json: @event
  end
end
