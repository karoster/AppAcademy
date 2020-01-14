class CatRentalRequestsController < ApplicationController

	def new
		@cats = Cat.all
		render :new
	end


	def create
		@request = CatRentalRequest.new(rental_params)

		if @request.save
			redirect_to cat_url(@request.cat_id)
		else
			redirect_to new_cat_rental_request_url
		end

	end

	def approve
		@cat_request = CatRentalRequest.find_by(id: params[:id])
		@cat = get_rental_request_by_id.cat
		get_rental_request_by_id.approve!
		redirect_to cat_url(@cat)
	end

	def deny
		@cat = get_rental_request_by_id.cat
		get_rental_request_by_id.deny!
		redirect_to cat_url(@cat)
	end



	private

	def get_rental_request_by_id
		@cat_request ||= CatRentalRequest.find_by(id: params[:id])
	end


	def rental_params
		params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
	end

end