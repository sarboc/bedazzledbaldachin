require 'spec_helper'

describe Event do

  self.instance_exec &$test_vars

  it "should have a status automatically set to true" do
    event.should respond_to(:event_status)
    event.event_status.should == true
  end

  it "should belong to party_type" do
    event.should respond_to(:party_type_id)
    event.party_type_id.should == party.id
    event.party_type.should == party
  end

  it "should belong to rating" do
    event.should respond_to(:rating_id)
    event.should respond_to(:rating)
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
