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


end