class CatRentalRequest < ApplicationRecord
	validate :does_not_overlap_approved_request
	validates :cat_id, :start_date, :end_date, presence: true
	validates :status, inclusion: {in: ['APPROVED', 'PENDING', 'DENIED'],
	  message: "Invalid request status"}


	belongs_to :cat,
		foreign_key: :cat_id,
		primary_key: :id,
		class_name: "Cat"



	def does_not_overlap_approved_request
		if overlapping_approved_requests.exists? && self.status == 'APPROVED'
			errors.add(:already_reserved, "You may not reserve a cat that is already reserved")
		end
	end

	def approve!
		self.status = 'APPROVED'
		CatRentalRequest.transaction do 
			self.save!
			overlapping_pending_requests.each do |pending_to_denied|
				pending_to_denied.status = 'DENIED'
				pending_to_denied.save!
			end
		end
	end

	def deny!
		self.status = "DENIED"
		self.save!
	end

	def pending?
		self.status == 'PENDING'
	end



	# helper functions to the above validation #


# A := query'd rental request
#Two cases of non violating request times (we not the below cases)
# | A |
#       |  B |
#AND
#|  B |
#  		|  A | 
	def overlapping_requests
		between_string = 'BETWEEN #{self.start_date} AND #{self.end_date}'

		CatRentalRequest
			.where.not(id: self.id)#don't want to pick self
			.where(cat_id: self.cat_id)
			.where.not('start_date > :end_date OR end_date < :start_date',
				start_date: self.start_date,
				end_date: self.end_date)
	end

	def overlapping_approved_requests
		overlapping_requests
		.where(status: 'APPROVED')
	end

	def overlapping_pending_requests
		overlapping_requests
		.where(status: 'PENDING')
	end


end