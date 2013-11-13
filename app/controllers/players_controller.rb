class PlayersController < ApplicationController
  def create
    player_info = params[:player]
    @player = Player.create(player_info)
    render :json => @player
  end
end
