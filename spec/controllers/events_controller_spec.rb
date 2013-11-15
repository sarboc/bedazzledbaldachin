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

    it "should restart the party if the event has been stopped" do
      event.start
      event.end
      put :update, id: event.id
      event.reload.event_status.should be_true
    end

    it "should reset the end time if the event is restarted" do
      event.start
      event.end
      event.start
      event.reload.end_time.should == event.start_time + 60 * 60 * 3
    end
  end
end

