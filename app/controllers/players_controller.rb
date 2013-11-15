class PlayersController < ApplicationController
  require 'rubygems'          # This line not needed for ruby > 1.8
  require 'twilio-ruby'

  def create
    @player = Player.create(params[:player])
    phone = @player.phone
    text = "Hi #{@player.name}. #{current_user.name} invited you to play. Please reply with 'y' to accept."
    send_text(phone, text)
    event_id = @player.event_id
    @players = Player.find_by_event_id(event_id)
    render :json => @players
  end
end
