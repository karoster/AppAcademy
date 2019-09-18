class Tagging < ApplicationRecord
	validates(:tag_id, presence: true)
	validates(:url_id, presence: true)

	belongs_to(
		:url,
		class_name: "ShortenedUrl",
		foreign_key: :url_id,
		primary_key: :id
		)

	belongs_to(
		:category,
		class_name: "TagTopic",
		foreign_key: :tag_id,
		primary_key: :id
		)
end