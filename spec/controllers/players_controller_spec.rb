require 'spec_helper'

describe PlayersController do

self.instance_exec &$test_vars
  before :each do
    sign_in @user
    @user.name = "testing"
  end

  describe "create" do
    # it "should create a new player" do
    #   Player.all.length.should == 0
    #   post :create, player: { phone: "9167476671", name: "Sara", event_id: event.id}
    #   Player.all.length.should == 1
    # end
  end


end

