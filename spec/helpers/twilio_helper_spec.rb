require 'spec_helper'

describe TwilioHelper do
  let(:party) { PartyType.create(description: "Super fun party!") }
  let(:rating) { Rating.create(name: "Super blush", value: 2) }
  let(:event) { Event.create(party_type_id: party.id, rating_id: rating.id) }

  let(:prompt1) {
    Prompt.create( description: "Do something fun!", rating_id: rating.id)
  }

  let(:prompt2) {
    Prompt.create(description: "Do something boring!", rating_id: rating2.id)
  }

  let(:phone){"+15102346789"}
  let(:name){"Miriam"}
  let(:player) { Player.create(name: name, phone: phone, event_id: event.id) }

  let(:player_prompt) { EventPrompt.create(event_id: event.id, player_id: player.id, prompt_id: prompt1.id)}

  let(:invalid_phone){"+14154567891"}

  describe "parse_message" do

    it "should return an error if a messager is not a player" do
      parse_message(invalid_phone, "anything") == "We don't know who you are. Sorry. Visit www.lederfeier.com to learn more."
    end

    describe "done and pass" do

      it "should return a message if the party hasn't started" do
        parse_message(player.phone, "done").should == "You don't have any prompts yet! Please wait until the party starts"
        parse_message(player.phone, "pass").should == "You don't have any prompts yet! Please wait until the party starts"
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
        parse_message(player.phone, "done").should == prompt1.description
        player.reload.event_prompts.length.should == 2
      end

      it "should return a new prompt if message is pass" do
        party.prompts << prompt1
        player_prompt
        player.event_prompts.length.should == 1
        parse_message(player.phone, "pass").should == prompt1.description
        player.reload.event_prompts.length.should == 2
      end

    end

    describe "leave" do

      it "should return leave when the message is leave" do
        parse_message(player.phone, "leave").should == "leave"
      end

    end

    describe "unknown message" do

      it "should return helpful error message when it doesn't know a message" do
        parse_message(player.phone, "next").should == "I don't know how to do that. Please respond with 'yes' to accept an invitation"
      end

    end
  end
end
