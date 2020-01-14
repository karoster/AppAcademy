class ArtworksController < ApplicationController

	def index
		user = User.find(params[:user_id])
		# N.B. this uses two queries. Could reduce it to one query by writing custom method.
		# (written in Artist class, passing in user_id as parameter)
		# drawback is output formatting doesn't necessarily separate owned art pieces vs. shared with art pieces. 
		render json: { owned: user.artworks, shared: user.views }
	end

	def show
		render json: get_art_by_id
	end

	def destroy
		artwork = get_art_by_id
		artwork.destroy
		render json: artwork
	end

	def create
		artwork = Artwork.new(artwork_params)

		if artwork.save
			render json: artwork
		else
			render json: artwork.errors.full_messages, status: :unprocessable_entity

		end
	end

	def update
		artwork = get_art_by_id

		if artwork.update_attributes(artwork_params)
			render json: artwork
		else
			render json: artwork.errors.full_messages, status: :unprocessable_entity
		end
	end


	private

	def artwork_params
		params.require(:artwork).permit(:title, :image_url, :artist_id)
	end

	def get_art_by_id
		Artwork.find(params[:id])
	end

end