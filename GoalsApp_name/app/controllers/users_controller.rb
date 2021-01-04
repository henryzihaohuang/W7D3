class UsersController < ApplicationController

    def new
        @user = User.new
        render :new
    end 
    
    
    def show
        # Params Explained
        # Path:/users/1  body: user: { username: “Henry” }
        # params: { id: 1, user: {username: “Henry” } }
        # user_params: { username: “Henry” }
        # ------
        # Path:/users/1  body: user: { username: “Henry”, extra_param: “blah”}
        # params: { id: 1, user: {username: “Henry”, extra_param: “blah”} }
        # user_params: { username: “Henry” }


        @user = User.find(params[:id])
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
