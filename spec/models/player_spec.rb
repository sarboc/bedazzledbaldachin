require 'spec_helper'

describe Player do
  self.instance_exec &$test_vars

  describe "get_new_prompt" do
    it "should add a new event_prompt for the player" do
      party.prompts << prompt1
      player.event_prompts.length.should == 0
      player.get_new_prompt
      player.event_prompts.length.should == 1
    end
  end

  describe "accept_invite" do
    it "should change accepted to true" do
      player.accepted.should be_false
      player.accept_invite
      player.reload.accepted.should be_true
    end

    it "should set start time for player" do
      player.start_time.should be_nil
      player.accept_invite
      player.start_time.should_not be_nil
    end
  end

  describe "create_by_passphrase" do
    it "should create a new player" do
      Player.all.length.should == 0
      Player.create_by_passphrase(event, invalid_phone)
      Player.all.length.should == 1
    end

    it "should have a name of 'passphrase_joiner'" do
      Player.create_by_passphrase(event, invalid_phone).name.should == "passphrase_joiner"
    end
  end

  describe "format_phone_number" do

  	it "should handle a perfect phone number" do #, focus: true do
      perfect_number = "+14083072406"
      player.update_attributes(phone: perfect_number)
      player.reload.phone.should == "+14083072406"
  	end

  	it "should handle a phone number with spaces" do
      dirty_number = "+1 408 307 2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end
  	it "should handle a phone number with spaces and dashes" do
      dirty_number = "+1 408-307-2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end
  	it "should handle a phone number with spaces dashes and brackets" do
      dirty_number = "+1 (408) 307-2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end


  end

end