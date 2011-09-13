require 'spec_helper'

describe "Relationships" do
  before(:each) do    
    @user = Factory(:user)
    @followed = Factory(:user, :email => Factory.next(:email))
    
    # @user must sign in to be able to follow/unfollow other users.
    visit signin_path
    fill_in :email, :with => @user.email
    fill_in :password, :with => @user.password
    click_button
  end
    
  describe "follow" do
    it "should follow another user" do
      visit user_path(@followed)
      click_button "Follow"
      @user.should be_following(@followed)
    end
  end
  
  describe "unfollow" do
    before(:each) do
      # Start the test as @user following @followed, so
      # that "Unfollow" button is enabled.
      @user.follow!(@followed)
    end
    
    it "should unfollow a user" do
      visit user_path(@followed)
      click_button "Unfollow"
      @user.should_not be_following(@followed)
    end
  end  
end