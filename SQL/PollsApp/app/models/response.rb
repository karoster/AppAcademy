class Response < ApplicationRecord


	belongs_to(:respondent,
		primary_key: :id,
		foreign_key: :respondent_id,
		class_name: 'User'
		)	

	belongs_to(:answer_choice,
		primary_key: :id,
		foreign_key: :answer_choice_id,
		class_name: 'AnswerChoice'
		)

	has_one(:question,
		through: :answer_choice,
		source: :question
		)


	validate :not_duplicate_response



	def not_duplicate_response
		if respondent_already_answered?
			errors[:duplicate] << 'can\'t give more than one response to a question'
		end
	end



	def sibling_responses
		self.question.responses.where.not(id: self.id)
	end

	def parent_poll
		self.question.poll
	end

	def respondent_is_poll_creator?
		parent_poll.author_id == self.respondent_id
	end

	def respondent_already_answered?
		sibling_responses.exists?(respondent_id: self.respondent_id)
	end

end