require 'spec_helper'


describe EventsController do
  self.instance_exec &$test_vars
  before :each do
    sign_in user1
  end

  describe "create" do
    it "should automatically add the current user as a player" do
      Player.all.length.should == 0
      post :create, event: { party_type_id: party.id, rating_id: rating.id, user_id: user1.id}
      Player.all.length.should == 1
    end
  end

  describe "update" do
    it "should start an event if an event has not been started" do
      event.start_time.should be_nil
      put :update, id: event.id
      event.reload.start_time.should_not be_nil
    end

    it "should stop an even if the event has been started" do
      event.start
      put :update, id: event.id
      event.reload.end_time.should_not be_nil
    end

  end
end

