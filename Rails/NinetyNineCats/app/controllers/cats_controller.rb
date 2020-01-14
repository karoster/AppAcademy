class CatsController < ApplicationController

	def index
		@cats = Cat.all
		render :index
	end

	def show
		@cat = Cat.find_by(id: params[:id])
		render :show
	end

	def new
		@cat = Cat.new
		render :new
	end

	def create
		@cat = Cat.new(cat_params)

		if @cat.save
			#save to DB was successful; show new cat object
			redirect_to cat_url(@cat) 
		else
			#save was unsuccessful; redirect to new form page again.
			render :new
		end

	end

	def edit
		@cat = Cat.find_by(id: params[:id])
		render :edit
	end

	def update
		@cat = Cat.find_by(id: params[:id])
		if  @cat.update_attributes(cat_params)
			redirect_to cat_url(@cat)
		else
			render :edit
		end

	end


	private

	def cat_params
		params.require(:cat).permit(:name, :birth_date, :color, :description, :sex)
	end


end