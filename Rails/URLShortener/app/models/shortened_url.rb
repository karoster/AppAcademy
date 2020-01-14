require 'securerandom'


class ShortenedUrl < ApplicationRecord
	validates :long_url, presence:true
	validates :short_url, presence: true, uniqueness: true
	validate :no_spamming
	validate :nonpremium_max

	belongs_to(
		:submitter,
		class_name: "User",
		foreign_key: :user_id,
		primary_key: :id
		)


#setting up visitor associations
	has_many(
		:visits,
		class_name: "Visit",
		foreign_key: :url_id,
		primary_key: :id
		)

	has_many(
		:visitors,
		Proc.new{ distinct },
		through: :visits,
		source: :user
		)

##setting up tag associations
	has_many(
		:taggings,
		class_name: "Tagging",
		foreign_key: :url_id,
		primary_key: :id
		)

	has_many(
		:tag_topics,
		through: :taggings,
		source: :category
		)

	##defining factory/instance methods

	def self.random_code
		shortened = nil
		while ShortenedUrl.exists?(short_url: shortened) || shortened.nil?
			shortened = SecureRandom.urlsafe_base64
		end
		shortened
	end

	def self.generate_shortened(usr, long_url)
		short_url = ShortenedUrl.random_code
		ShortenedUrl.create!(user_id: usr.id,
			 short_url: short_url,
			 long_url: long_url)
	end

	def num_clicks
		self.visitors.length
	end

	def num_uniques
		self.visitors.count
	end

	def num_recent_uniques
		self.visitors.where(
			"visits.created_at >= CURRENT_DATE - INTERVAL '10 minutes'"
			).count
	end

	def no_spamming
		num_recent_urls_from_user = ShortenedUrl.where("user_id = ? AND 
			created_at >= NOW() - INTERVAL '1 minute'", self.user_id)
			.length
		if num_recent_urls_from_user >= 5
			errors[:spamming] << "you can not submit that many URLs in one minute."
		end
	end

	def nonpremium_max
		user_premium = User.where(id: self.user_id)
			.pluck("premium")
		num_urls_from_user = ShortenedUrl
			.where(user_id: self.user_id)
			.length
		if num_urls_from_user > 5 && !user_premium[0]
			errors[:exceeded] << "maximum nonpremium URL shortenings (5)"
		end
	end

	def self.prune(n)
		stale_urls = ShortenedUrl.all
			.left_outer_joins(:visits)
			.where("visits.created_at <= NOW() - INTERVAL '? minutes' OR
				visits.id IS NULL", n)
			.destroy_all

	end

end

# u1 = User.create!(email: 'jefferson@cats.com', premium: true)
# u2 = User.create!(email: 'muenster@cats.com')

# su1 = ShortenedUrl.generate_shortened(u1, 'www.boxes.com')
# su2 = ShortenedUrl.generate_shortened(u2, 'www.meowmix.com')
# su3 = ShortenedUrl.generate_shortened(u2, 'www.smallrodents.com')

# v1 = Visit.create!(user_id: u1.id, url_id: su1.id)
# v2 = Visit.create!(user_id: u1.id, url_id: su2.id)

# ShortenedUrl.all # should return su1, su2 and su3
# ShortenedUrl.prune(10)
# ShortenedUrl.all # should return su1, su2 and su3