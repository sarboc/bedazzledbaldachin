require 'spec_helper'

describe PartyType do
  self.instance_exec &$test_vars

  it "should have many paty_type_prompts" do
    party.should respond_to(:party_type_prompts)
  end

  it "should have many prompts" do
    party.should respond_to(:prompts)
  end

  it "should have many events" do
    party.should respond_to(:events)
  end

end
