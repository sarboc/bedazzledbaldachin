require 'spec_helper'

describe PlayersController do

  self.instance_exec &$test_vars

  before :each do
    sign_in user1
  end

  describe "create" do
    it "should create a new player" do
      Player.all.length.should == 0
      post :create, player: { phone: "4569867584", name: "Sara", event_id: event.id}
      Player.all.length.should == 1
    end

    it "should send an invite to the new player" do
      post :create, player: {phone: "1234567891", name: "Sara", event_id: event.id}
      player = Player.last
      open_last_text_message_for player.phone
      current_text_message.should have_body "Hi Sara. Jimmy has invited you to play Lederfeier. Please reply with 'y' to accept."
    end
  end


end

