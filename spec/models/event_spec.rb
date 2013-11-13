require 'spec_helper'


describe Event do
  before :each do
    Event.any_instance.stub(:get_random_word).and_return("watermelon", "icepick")
  end

  let(:party) { PartyType.create(description: "Super fun party!") }
  let(:party2) { PartyType.create(description: "Boring party!") }

  let(:rating) { Rating.create(name: "Super blush", value: 2) }
  let(:rating2) { Rating.create(name: "No blush", value: 1) }

  let(:event) { Event.create(party_type_id: party.id, rating_id: rating.id) }

  let(:prompt1) {
    Prompt.create( description: "Do something fun!", rating_id: rating.id)
    party.prompts << prompt1
  }

  let(:prompt2) {
    Prompt.create(description: "Do something boring!", rating_id: rating2.id)
    party2.prompts << prompt2
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
  end

  it "should belong to party_type" do
    event.should respond_to(:party_type_id)
    event.party_type_id.should == party.id
    event.party_type.should == party
  end

  it "should belong to rating" do
    event.should respond_to(:rating_id)
    event.rating_id.should == rating.id
    event.rating.should == rating
  end

  it "should auto-assign a wordnik passphrase" do
    event.should respond_to(:wordnik)
    event.wordnik.should_not be_nil

    # make sure there are two words separated by a space
    event.wordnik.should include(" ")

    # make sure there are only two words
    event.wordnik.split(" ").length.should == 2

    event.wordnik.should == "watermelon icepick"
  end

  it "should have access to prompts" do
    event.should respond_to(:prompts)
  end

  describe "Random Prompt" do
    it "should have a method random_prompt" do
      event.should respond_to(:random_prompt)
      # event.random_prompt.should == prompt1
    end
  end

end
