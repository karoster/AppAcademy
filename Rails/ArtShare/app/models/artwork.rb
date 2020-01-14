class Artwork < ApplicationRecord

	validates :title, presence: true, uniqueness:
		{ scope: :artist_id, message: "Artist should have only one project of a given name" }
	validates :image_url, presence: true


	belongs_to :artist,
		foreign_key: :artist_id,
		primary_key: :id,
		class_name: "User"

	has_many :shares,
		foreign_key: :artwork_id,
		primary_key: :id,
		class_name: "ArtworkShare"

	has_many :comments,
		foreign_key: :artwork_id,
		primary_key: :id,
		class_name: "Comment",
		dependent: :destroy

	has_many :shared_viewers,
		through: :shares,
		source: :viewer



end