class EventsController < ApplicationController

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
