require 'spec_helper'

describe TwiliosHelper do
  self.instance_exec &$test_vars

  describe "parse_message" do

    it "should return an error if a messager is not a player" do
      parse_message(invalid_phone, "anything") == "We don't know who you are. Sorry. Visit www.lederfeier.com to learn more."
    end

    describe "done and pass" do

      it "should return a message if the party hasn't started" do
        parse_message(player.phone, "done").should == no_prompts_message
        parse_message(player.phone, "pass").should == no_prompts_message
      end

      it "should mark a player's prompt as completed if message is done" do
        party.prompts << prompt1
        player_prompt.completed.should == false
        parse_message(player.phone, "done")
        player_prompt.reload.completed.should == true
        player_prompt.passed.should == false
      end

      it "should mark a player's prompt as passed if message is pass" do
        party.prompts << prompt1
        player_prompt.passed.should == false
        parse_message(player.phone, "pass")
        player_prompt.reload.passed.should == true
        player_prompt.completed.should == false
      end

      it "should return a new prompt if message is done" do
        party.prompts << prompt1
        player_prompt
        player.event_prompts.length.should == 1
        parse_message(player.phone, "done").should == prompt1.description + instructions
        player.reload.event_prompts.length.should == 2
      end

      it "should return a new prompt if message is pass" do
        party.prompts << prompt1
        player_prompt
        player.event_prompts.length.should == 1
        parse_message(player.phone, "pass").should == prompt1.description + instructions
        player.reload.event_prompts.length.should == 2
      end

      it "should match any message containing 'done'" do
        parse_message(player.phone, "sdfs done ssd").should == no_prompts_message
      end

      it "should match any message containing 'pass'" do
        parse_message(player.phone, "jlkjlkjpasskjlkj").should == no_prompts_message
      end

      it "should return a new prompt if message is pass" do
        party.prompts << prompt1
        player_prompt
        player.event_prompts.length.should == 1
        parse_message(player.phone, "pass").should == prompt1.description + instructions
        player.reload.event_prompts.length.should == 2
      end
    end

    describe "yes-ish things" do
      it "should set a player to accepted" do
        player.accepted.should == false
        parse_message(player.phone, "y")
        player.reload.accepted.should == true
      end

      it "should set player start time to not nil" do
        player.start_time.should be_nil
        parse_message(player.phone, "ok")
        player.reload.start_time.should_not be_nil
      end

      it "should not overide player start-time if user repeats yes-ish command" do
        player.start_time.should be_nil
        parse_message(player.phone, "yes")
        start_time = player.reload.start_time
        start_time.should_not be_nil
        parse_message(player.phone, "yes")
        player.reload.start_time.should == start_time
      end

      # it "should recieve already joined if user repeats yes-ish command" do
      #   parse_message(player.phone, "yes").should == accepted_message
      #   parse_message(player.phone, "yes").should == already_accepted_message
      # end

      it "should respond with a welcome message" do
        parse_message(player.phone, "accept").should == accepted_message
      end
    end

    describe "leave" do

      it "should return leave when the message is leave" do
        parse_message(player.phone, "leave").should == leave_text
      end

      it "should assign the current time to end_time" do
        player.end_time.should be_nil
        parse_message(player.phone, "leave")
        player.reload.end_time.should_not be_nil
      end

    end

    describe "unknown message" do

      it "should return helpful error message when it doesn't know a message" do
        parse_message(player.phone, "next").should == unknown_text
      end

    end

    describe "join by passphrase" do

      # it "should add the player if the message matches an event passphrase" do
      #   event
      #   event.players.length.should == 0
      #   parse_message(invalid_phone, "watermelon icepick").should == "Thanks for joining! What's your name?"
      #   event.reload.players.length.should == 1
      # end

      # it "should be case insensitive" do
      #   event
      #   parse_message(invalid_phone, "Watermelon Icepick").should == "Thanks for joining! What's your name?"
      # end

      # it "should treat the next message as a name" do
      #   parse_message(invalid_phone, event.wordnik)
      #   parse_message(invalid_phone, "Sara").should == "Welcome, Sara!"
      #   Player.last.name.should == "Sara"
      # end

      # it "should treat a player normally after a name is sent" do
      #   parse_message(invalid_phone, event.wordnik)
      #   parse_message(invalid_phone, "Sara")
      #   parse_message(invalid_phone, "done").should == no_prompts_message
      #   parse_message(invalid_phone, "y").should == already_accepted_message
      # end

    end
  end
end

