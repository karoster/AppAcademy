class User < ApplicationRecord
	validates :email, presence: true, uniqueness: true
	validates :name, presence: true 

	has_many :artworks,
		foreign_key: :artist_id,
		primary_key: :id,
		class_name: "Artwork"

	has_many :views,
		foreign_key: :viewer_id,
		primary_key: :id,
		class_name: "ArtworkShare"

	has_many :comments,
		foreign_key: :user_id,
		primary_key: :id,
		class_name: "Comment",
		dependent: :destroy


	has_many :shared_artworks,
		through: :views,
		source: :artwork

	def get_shares
		self
		  .joins(:shares)
		  .where("artwork_shares.artwork_id = id OR artwork_shares")
	end

end