class Question < ApplicationRecord
	validates :text, presence: true


	has_many(:answer_choices,
		primary_key: :id,
		foreign_key: :question_id,
		class_name: 'AnswerChoice'
		)

	belongs_to(:poll,
		primary_key: :id,
		foreign_key: :poll_id,
		class_name: 'Poll'
		)

	has_many(:responses,
		through: :answer_choices,
		source: :responses
		)

	#a classic n+1 query
	def results_naive
		ans_hash = {}
		answers = self.answer_choices
		answers.each do |answer|
			ans_hash[answer.text] =  answer.responses.count
		end
		ans_hash

	end

	#includes pre fetches responses at same time fetch answer_choices.
	#still not great, it is memory inefficient, we are really only interested
	#in the counts
	def results_naive2
		ans_hash = {}
		answers = self.answer_choices.includes(:responses)
		answers.each do |ans|
			ans_hash[ans.text] = ans.responses.length
		end
		ans_hash
	end

	#this query uses minimal space and is easy to read.
	def result
		ans = self.answer_choices
		.select('answer_choices.text, COUNT(responses.id) AS votes')
		.left_outer_joins(:responses)
		.group('id')
		
	
		ans.inject({}) do |result, an|
			result[an] = an.votes
			result
		end
	end

end

