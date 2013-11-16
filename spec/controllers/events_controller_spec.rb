require 'spec_helper'


describe EventsController do
  self.instance_exec &$test_vars
  before :each do
    sign_in
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

