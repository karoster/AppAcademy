class ArtworkSharesController < ApplicationController

	def create
		share = ArtworkShare.new(artwork_share_params)		
		if share.save
			render json: share
		else
			render json: share.errors.full_mesages, status: :unprocessable_entity
		end
	end

	def destroy
		share = find_share_by_id
		share.destroy
		render json: share

	end


	private

	def find_share_by_id
		ArtworkShare.find(params[:id])
	end

	def artwork_share_params
		params.require(:artwork_share).permit(:viewer_id, :artwork_id)
	end

end