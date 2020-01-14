class User < ApplicationRecord
	validates :email, uniqueness: true

	has_many(
		:submitted_urls,
		class_name: "ShortenedUrl",
		foreign_key: :user_id,
		primary_key: :id
		)
	has_many(
		:urls,
		class_name: "Visit",
		foreign_key: :user_id,
		primary_key: :id
		)

	has_many(
		:visited_urls,
		Proc.new { distinct },
		through: :urls,
		source: :url
		)
end