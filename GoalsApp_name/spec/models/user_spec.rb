require 'rails_helper'

RSpec.describe User, type: :model do
  
  subject(:test_subject) do
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

  describe "is_password?(password)" do 
    #<= let allows us access to test_user so can call things like test_user.username

    #test_user = User.create(username: Faker::Movies::LordOfTheRings.character, password: Faker::Internet.password) **From our factory

    let!(:test_user) { create(:user) } 
    context "with valid password" do 
      it "should return true" do 
        expect(test_user.is_password?(test_user.password)).to be true
      end
    end

    context "with invalid password" do
      it "should return false" do 
        expect(test_user.is_password?('a')).to be false
      end
    end
  end
    
end
