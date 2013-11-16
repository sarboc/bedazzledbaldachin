require 'spec_helper'

describe EventPrompt do
  self.instance_exec &$test_vars

  it "should belong to event" do
    player_prompt.should respond_to(:event)
  end

  it "should belong to player" do
    player_prompt.should respond_to(:player)
  end

  it "should belong to prompt" do
    player_prompt.should respond_to(:prompt)
  end

end
