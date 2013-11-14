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

    describe "yes-ish things" do
      it "should set a player to accepted" do
        player.accepted.should == false
        parse_message(player.phone, "yes")
        player.reload.accepted.should == true
      end

      it "should respond with a welcome message" do
        parse_message(player.phone, "yes").should == "welcome message"
      end
    end

    end

    describe "done" do

      it "should return a message if the part hasn't started" do
        parse_message(player.phone, "done").should == "You don't have any prompts yet! Please wait until the party starts"
      end

      it "should mark a user's prompt as done" do
        player_prompt.completed.should == false
        parse_message(player.phone, "done")
        player_prompt.reload.completed.should == true
      end

    end

    describe "pass" do

      it "should return pass when the message is pass" do
        parse_message(player.phone, "pass").should == "pass"
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
