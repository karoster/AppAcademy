# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

u1 = User.create!(username: "Kat")
u2 = User.create!(username: "Karl")
u3 = User.create!(username: "Ross")

p1 =Poll.create!(title: "best roommate quiz", author: u2 )

q1 = Question.create!(text: "How many times/week do you do the dishes?", poll: p1)
q1a1 = AnswerChoice.create!(text: "1", question: q1)
q1a2 = AnswerChoice.create!(text: "2", question: q1)
q1a3 = AnswerChoice.create!(text: "3", question: q1)
q1a4 = AnswerChoice.create!(text: "4", question: q1)


q2 = Question.create!(text: "How many times/week do you take out the trash?", poll: p1)
q2a1 = AnswerChoice.create!(text: "1", question: q2)
q2a2 = AnswerChoice.create!(text: "2", question: q2)
q2a3 = AnswerChoice.create!(text: "3", question: q2)

q3 = Question.create!(text: "How many times/week do you clean the kitchen?", poll: p1)
q3a1 = AnswerChoice.create!(text: "1", question: q3)
q3a2 = AnswerChoice.create!(text: "2", question: q3)

u1r1 = Response.create!(respondent: u1, answer_choice: q1a1)
u1r2 = Response.create!(respondent: u1, answer_choice: q2a3)
u1r3 = Response.create!(respondent: u1, answer_choice: q3a1)


u3r1 = Response.create!(respondent: u3, answer_choice: q1a4)
u3r2 = Response.create!(respondent: u3, answer_choice: q2a2)
u3r3 = Response.create!(respondent: u3, answer_choice: q3a2)


