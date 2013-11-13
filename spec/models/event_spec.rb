require 'spec_helper'

describe Event do
  let(:party_type_id){2}
  let(:rating_id){1}

  let(:event) {
    Event.create(
      party_type_id: party_type_id,
      rating_id: rating_id
    )
  }

  it "should have a status automatically set to true" do
    event.should respond_to(:event_status)
    event.event_status.should == true
  end

  it "should automatically add a start time" do
    event.should respond_to(:start_time)
    event.start_time.should_not be_nil
  end

  it "should automatically add an end time" do
    event.should respond_to(:end_time)
    event.end_time.should_not be_nil
  end

  it "should have an end time 3 hours after end time" do
    event.end_time.should == event.start_time + 60 * 60 * 3
    (event.end_time.hour - event.start_time.hour).should == 3
  end

  it "should belong to party_type" do
    event.should respond_to(:party_type)
  end

  it "should belong to rating" do
    event.should respond_to(:rating)
  end

  it "should auto-assign a wordnik passphrase" do
    event.should respond_to(:wordnik)
    event.wordnik.should_not be_nil
  end

end
