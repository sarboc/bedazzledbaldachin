require 'spec_helper'

describe Event do

  self.instance_exec &$test_vars

  it "should belong to user" do
    event.should respond_to(:user)
    event.user_id.should == user1.id
    event.user.should == user1
  end

  it "should increment length counter when created" do
    user1.events.length.should == 0
    event 
    user1.reload.events.length.should == 1
  end

  it "should not be allowed to have 2 active events" do
    user1.events.length.should == 0
    event
    user1.reload.events.length.should == 1
    event2
    user1.reload.events.length.should == 1
  end

  it "should allow user to create event after prior event has ended" do
    user1.events.length.should == 0
    event.end
    user1.reload.events.length.should == 1
    event2
    user1.reload.events.length.should == 2
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

  it "should belong to user" do
    event.should respond_to(:user)
  end

  it "should have many prompts" do
    event.should respond_to(:prompts)
  end

  it "should have many players" do
    event.should respond_to(:players)
  end

  it "should have many event_prompts" do
    event.should respond_to(:event_prompts)
  end

  it "should have many prompts" do
    event.should respond_to(:prompts)
  end

  it "should auto-assign a wordnik passphrase" do
    event.should respond_to(:wordnik)
    event.reload.wordnik.should_not be_nil

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
      party.prompts << prompt1
      event.should respond_to(:random_prompt)
      event.random_prompt.should == prompt1
    end
  end

  describe "start" do
    it "should add a start time to the event" do
      event.start_time.should be_nil
      event.start
      event.reload.start_time.should_not be_nil
    end

    it "should set the event status to true" do
      event.start
      event.reload.event_status.should be_true
    end

    it "should send a prompt to all accepted players" do
      party.prompts << prompt1
      player.accept_invite
      event.start
      open_last_text_message_for player.phone
      current_text_message.should have_body prompt1.description + instructions
    end
  end

  describe "end" do
    it "should add an end time to the event" do
      event.end
      event.reload.end_time.should_not be_nil
    end

    it "should set event status to false" do
      event.end
      event.reload.event_status.should be_false
    end

    it "should leave all players" do
      player
      event.players.length.should == 1
      event.end
      event.players.where("end_time is null").length.should == 0
    end

    it "should mark a player's end time" do
      player.end_time.should be_nil
      event.end
      player.reload.end_time.should_not be_nil
    end

  end

end
