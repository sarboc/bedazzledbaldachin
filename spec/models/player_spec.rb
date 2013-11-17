require 'spec_helper'

describe Player do
  self.instance_exec &$test_vars

  it "should have many event_prompts" do
    player.should respond_to(:event_prompts)
  end

  it "should have many prompts" do
    player.should respond_to(:prompts)
  end

  it "should have one event" do
    player.should respond_to(:event)
  end

  it "should require phone" do
    Player.all.length.should == 0
    player = Player.new
    player.event = event
    player.name = "Sara"
    player.save
    Player.all.length.should == 0
  end

  it "should require name" do
    Player.all.length.should == 0
    player = Player.new
    player.event = event
    player.phone = phone
    player.save
    Player.all.length.should == 0
  end

  it "should require event_id" do
    Player.all.length.should == 0
    player = Player.new
    player.phone = phone
    player.name = "Sara"
    player.save
    Player.all.length.should == 0
  end

  it "should create  player given name phone and event" do    
    Player.all.length.should == 0
    player1 = Player.create(name: name, phone: phone, event_id: event.id)
    Player.all.length == 1
  end

  it "should not allow a player to join an event if already in an event" do
    Player.all.length.should == 0
    event
    player1 = Player.create(name: name, phone: phone, event_id: event.id)
    Player.all.length == 1
    event3
    player3 = Player.create(name: name, phone: phone, event_id: event3.id)
    Player.all.length == 1
  end

  it "should alow a player to join an event after left an event" do
    Player.all.length.should == 0
    event
    player1 = Player.create(name: name, phone: phone, event_id: event.id)
    Player.all.length == 1
    event.end
    event3
    player3 = Player.create(name: name, phone: phone, event_id: event3.id)
    Player.all.length == 2
  end

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

    it "should have a name of 'passphrase joiner'" do
      Player.create_by_passphrase(event, invalid_phone).name.should == "passphrase joiner"
    end
  end

  describe "format_phone_number" do

  	it "should handle a perfect phone number" do
      perfect_number = "4083072406"
      player.update_attributes(phone: perfect_number)
      player.reload.phone.should == "+14083072406"
  	end

  	it "should handle a phone number with spaces" do
      dirty_number = "408 307 2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end

  	it "should handle a phone number with spaces and dashes" do
      dirty_number = "408-307-2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end

  	it "should handle a phone number with spaces dashes and brackets" do
      dirty_number = "(408) 307-2406"
      player.update_attributes(phone: dirty_number)
      player.reload.phone.should == "+14083072406"
  	end

    it "should not mess up an already perfect phone number" do
      clean_number = "+14151234567"
      player.update_attributes(phone: clean_number)
      player.reload.phone.should == clean_number
    end

  end

  describe "send text" do
    it "should send a message to the player's phone" do
      player.send_text("Hello")
      open_last_text_message_for player.phone
      current_text_message.should have_body "Hello"
    end
  end

  describe "leave" do
    it "should set the end time for a player" do
      player.leave
      player.reload.end_time.should_not be_nil
    end
  end

end