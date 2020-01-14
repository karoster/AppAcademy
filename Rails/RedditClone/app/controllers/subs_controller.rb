class SubsController < ApplicationController
    before_action :must_be_moderator, only: [:edit, :update]

    def index
        @subs = Sub.all
        render :index
    end

    def show
        @sub = Sub.find_by(id: params[:id])
        render :show
    end

    def new
        @sub = Sub.new()
        render :new
    end

    def create
        @sub = Sub.new(sub_params)
        @sub.creator_id = current_user.id
        if @sub.save
            redirect_to sub_url(@sub)
        else
            flash[:errors] = @sub.errors.full_messages
            render :new
        end
    end

    def edit
        @sub.find_by(id: params[:id])
        render :edit
    end

    def update
        @sub = Sub.find_by(id: params[:id])

        if @sub.update_attributes
            redirect_to sub_url(@sub)
        else
            flash[:errors]
            render :edit
        end
    end

    private

    def sub_params
        params.require(:sub).permit(:title, :description)
        
    end

end