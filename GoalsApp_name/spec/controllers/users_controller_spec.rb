require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET#new" do
        it "should render the create user page" do 
            expect(response).to render_template(:new)
        end

    end

    describe "GET#show" do
        it "should show a single user's page" do
            expect(response).to render_template(:show)
        end
    end

    describe "POST#create" do
        let(:valid_params) { { users: {username: 'John', password:'asdfasdf'}} }
        let(:invalid_params) { { users: {username: 'John', password:'as'}} }
    
    
        context "with valid params" do
            before(:each) {post :create, params: valid_params}

            it "should create a user " do
                expect(response).to redirect_to(user_url)
            end
        end

        context "invalid params" do
            before(:each) { post :create, params: invalid_params }

            it "should redirect to new user page" do
                expect(response).to render_template(:new)
            end
        end
    end

    

end
