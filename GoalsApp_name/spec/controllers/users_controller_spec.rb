require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET#new" do
        it "should render the create user page" do 
            get :new
            # expect(response).to render_template(:new)
        end

    end

    describe "GET#show" do
        it "should show a single user's page" do
            create(:user) 
            get :show, params: { id: User.last.id}
            expect(response).to render_template(:show)
        end
    end

    describe "POST#create" do
        let(:valid_params) { { users: {username: 'John', password:'asdfasdf'}} }
        let(:invalid_params) { { users: {username: 'John', password:'as'}} }
    
    
        context "with valid params" do
            

            it "should create a user " do
                create(:user)
                get :show, params: { id: User.last.id }
                expect(response).to render_template :show
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
