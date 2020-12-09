require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject(:user) do
    FactoryBot.build(:user, 
    username:"John", 
    password:"asdfasdf")

  end

  it { should validate_presence_of(:username)}
  it { should validate_presence_of(:password_digest)}
  it { should validate_presence_of(:session_token)}
  it { should validate_length_of(:password).is_at_least(6)}

  describe "uniqueness" do
    before(:each) do
      create(:user)
    end

    it {should validate_uniqueness_of(:username)}
    it {should validate_uniqueness_of(:session_token)}
  end

  describe "::find_by_credentials" do
    
    it "should return a user if valid credentials" do
      expect(User.find_by_credentials("John", 
      "asdfasdf")).to eq(user)
    end
      
    it "should return nil if invalid credentials" do
      expect(User.find_by_credentials("John", 
      "a")).to eq(nil)
    end
  end


end
