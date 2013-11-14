class PlayersController < ApplicationController
  include EventsHelper
  require 'rubygems'          # This line not needed for ruby > 1.8
  require 'twilio-ruby'

  def create
    player_info = params[:player]
    @player = Player.create(player_info)
    phone = @player.phone
    text = "Hi #{@player.name}. #{current_user.name} invited you to play. Please reply with 'y' to accept."
    send_text(phone, text)
    render :json => @player
  end
end
