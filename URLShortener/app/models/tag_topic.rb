class TagTopic < ApplicationRecord
	validates(:tag, presence: true)

	has_many(
		:tagging_urls,
		class_name: "Tagging",
		foreign_key: :tag_id,
		primary_key: :id,
		dependent: :destroy
		)

	has_many(
		:links,
		through: :tagging_urls,
		source: :url
		)



	def popular_links
		links.joins(:visits)
			.group(:short_url, :long_url)
			.order('COUNT(visits.id) DESC')
			.limit(5)
			.pluck('long_url, short_url, COUNT(visits.id) AS number_visits')
	end

end