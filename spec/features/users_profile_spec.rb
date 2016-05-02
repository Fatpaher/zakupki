require "rails_helper"

describe "Login user visit profile page" do
  before do
   @user = create :user
   login_as @user
  end
  it "sees his purchase summry info" do
    visit root_path

    click_link profile
  end

  it "sees his purchases list"
  it "sees groups he is consists"
  it "sees his subscribes"
  it "sees his profile info"
  it "can change his password"
end
