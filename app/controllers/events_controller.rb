class EventsController < ApplicationController

# Get twilio-ruby from twilio.com/docs/ruby/install

  def index

  end

  def new
    @event = Event.new
 
    # MK commenting this out - user is the current_user and we know that
    #@user = User.new
  end

  def create

    # MK adding these two lines.  Is this 'create' hash correct? 
    @event = Event.create(:rating_id => params[:rading_id], :party_type_id => params[:party_type_id])
    # note owner is added in the after_create scope in the model
    @owner = current_user
    #check syntax below
    render :json => @event + @owner
  end

  def show
  end

end
