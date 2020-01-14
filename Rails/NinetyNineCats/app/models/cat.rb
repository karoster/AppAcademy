class Cat < ApplicationRecord
	include ActionView::Helpers::DateHelper
	COLORS = ["black", "white", "gray", "orange"]

	validates :birth_date, :color, :name, :sex, presence: true
	validates :color, inclusion: { in: COLORS,
	  message: "color does not match list of acceptable colors" }

	has_many :rental_requests,
		foreign_key: :cat_id,
		primary_key: :id,
		class_name: "CatRentalRequest",
		dependent: :destroy


	def age
		now_time = DateTime.now
		year_age = now_time.year - self.birth_date.year
		if birthday_this_year?(now_time)
			year_age
		else
			year_age - 1
		end
	end

	def birthday_this_year?(now_time)
		(now_time.month > self.birth_date.month) ||
		  (now_time.month == self.birth_date.month &&
		    now_time.day >= self.birth_date.day)	 
	end

	### Helper Fxns ###

	def get_colors
		COLORS
	end


end