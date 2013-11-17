require 'spec_helper'

describe PartyTypePrompt do
  self.instance_exec &$test_vars

  it "should belong to party_type" do
    record = PartyTypePrompt.create(party_type_id: 1, prompt_id: 2)
    record.should respond_to(:party_type)
  end

  it "should belong to prompt" do
    record = PartyTypePrompt.create(party_type_id: 1, prompt_id: 2)
    record.should respond_to(:prompt)
  end

  it "should add a new record when a join record is added" do
    PartyTypePrompt.all.length.should == 0
    party.prompts << prompt1
    PartyTypePrompt.all.length.should == 1
  end


end
