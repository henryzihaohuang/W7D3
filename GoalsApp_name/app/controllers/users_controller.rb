class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end 
    
    
    def show
        @user = User.find_by(user_params)
        render :show
    end
        
        
    def create
        @user = User.new(user_params)

        if @user.save
            session[:session_token] = @user.reset_session_token
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end


    private
    def user_params
        params.require(:users).permit(:username, :password)
    end
end
