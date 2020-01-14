class ApplicationController < ActionController::Base

    def current_user
        @cur_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        current_user.nil? ? false : true
    end

    def log_in!(user)
        user.reset_session_token!
        session[:session_token] = user.session_token
    end

    def log_out!(user)
        session[:session_token] = nil
        user.reset_session_token!
    end

    def must_be_moderator
        user = current_user
        cur_sub = Sub.find_by(id: params[:id])
        redirect_to sub_url(params[:id]) unless cur_sub.creator_id == user.id 
    end

    def must_be_author
        user = current_user
        cur_post = Post.find_by(id: params[:id])
        redirect_to post_url(cur_post) unless user.id == cur_post.author_id
    end

    helper_method :current_user, :logged_in?
end
