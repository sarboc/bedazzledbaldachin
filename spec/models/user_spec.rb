require 'spec_helper'


describe User do
  self.instance_exec &$test_vars

  it "should have been tested by Divise" do
    #let's hope
  end

  describe "clean_phone_number" do

    it "should do nothing if the user doesn't have a phone number" do
      user2.phone.should be_nil
      user2.update_attributes(name: "Sara")
      user2.reload.phone.should be_nil
    end

    it "should clean a phone number with spaces dashes and brackets" do
      dirty_number = "(408) 307-2406"
      user1.update_attributes(phone: dirty_number)
      user1.reload.phone.should == "+14083072406"
    end

    it "should not mess up an already perfect phone number" do
      clean_number = "+14151234567"
      user1.update_attributes(phone: clean_number)
      user1.reload.phone.should == clean_number
    end

  end

end
