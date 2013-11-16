require 'spec_helper'

describe Prompt do
  self.instance_exec &$test_vars

  it "should belong to rating" do
    prompt1.should respond_to(:rating)
  end

  it "should have many event_prompts" do
    prompt1.should respond_to(:event_prompts)
  end

  it "should have many party types" do
    prompt1.should respond_to(:party_types)
  end

  it "should have many party_type_promots" do
    prompt1.should respond_to(:party_type_prompts)
  end

  it "should require description" do
    Prompt.all.length.should == 0
    prompt = Prompt.new
    prompt.rating = rating
    prompt.save
    Prompt.all.length.should == 0
  end

  it "should require rating" do
    Prompt.all.length.should == 0
    prompt = Prompt.new
    prompt.description = "testing"
    prompt.save
    Prompt.all.length.should == 0
  end

end
