require 'spec_helper'

describe TwilioHelper do
  let(:party) { PartyType.create(description: "Super fun party!") }
  let(:rating) { Rating.create(name: "Super blush", value: 2) }
  let(:event) { Event.create(party_type_id: party.id, rating_id: rating.id) }

  let(:phone){"+15102346789"}
  let(:name){"Miriam"}
  let(:player) { Player.create(name: name, phone: phone, event_id: event.id) }

  let(:invalid_phone){"+14154567891"}

  describe "parse_message" do

    it "should return an error if a messager is not a player" do
      parse_message(invalid_phone, "anything") == "We don't know who you are. Sorry. Visit www.lederfeier.com to learn more."
    end

    describe "done" do

      it "should return done when the message is done" do
        parse_message(player.phone, "done").should == "done"
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
        parse_message(player.phone, "next").should == "I don't know that"
      end

    end



  end
end
