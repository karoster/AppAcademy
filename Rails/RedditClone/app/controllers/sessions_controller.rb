class SessionsController < ApplicationController

    def new
        render :new
    end

    def create
        username, password  = params[:user][:username], params[:user][:password]
        @user = User.find_by_credentials(username, password)
        p "printing @user:", @user
        if @user
            log_in!(@user)
            redirect_to subs_url
        else
            flash[:errors] = ["invalid username or password"]
            render :new
        end
    end

    def destroy
        @user = current_user
        log_out!(@user)
        redirect_to subs_url
    end

end