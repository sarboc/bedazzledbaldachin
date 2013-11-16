require 'spec_helper'

describe Rating do
  self.instance_exec &$test_vars

  it "should have many events" do
    rating.should respond_to(:events)
  end

  it "should have many prompts" do
    rating.should respond_to(:prompts)
  end

  it "should require a name" do
    Rating.all.length.should == 0
    rating = Rating.new
    rating.value = 1
    rating.save
    Rating.all.length.should == 0
  end

  it "should require a value" do
    Rating.all.length.should == 0
    rating = Rating.new
    rating.name = "testing"
    rating.save
    Rating.all.length.should == 0
  end

end
