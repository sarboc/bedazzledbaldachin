class PlayersController < ApplicationController
  require 'rubygems'          # This line not needed for ruby > 1.8
  require 'twilio-ruby'

  def create
    @player = Player.create(params[:player])
    text = "Hi #{@player.name}. #{current_user.name} has invited you to play Lederfeier. Please reply with 'y' to accept."
    @player.send_text(text)
    render :json => @player
  end
end
