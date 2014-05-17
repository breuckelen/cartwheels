class SessionsController < ApplicationController
    def new
        if !session[:user_id].nil?
            redirect_to root_url
        end
    end

    def create
        username = session_params[:username]

        if User.authenticate(username, session_params[:password])
            user = User.find_by_username(username)
            session[:user_id] = user.id
            redirect_to root_url
        else
            flash[:notice] = "Username and password did not match"
            render "new"
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url
    end

    def session_params
        params.permit(:username, :password)
    end
end
