class PostsController < ApplicationController
    before_action :must_be_author, only: [:edit, :update]

    def show
        @post = Post.find_by(id: params[:id])
        @comments = @post.comments_by_parent_id
        p @comments
        render :show
        #post_url(params[:id])
    end

    def new
        @post = Post.new()
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save
            redirect_to post_url(@post)
        else
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def edit
        @post = Post.find_by(id: params[:id])
        render :edit
    end

    def update
        @post = Post.find_by(id: params[:id])
        if @post.update_attributes
            redirect_to post_url
        else
            flash[:errors] = @post.errors.full_messages
            render :edit
        end
    end


    private

    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids:[])
    end
end