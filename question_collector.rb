require 'CSV'
require './models/question'
require './models/question_impression'
require 'pry'

class QuestionCollector
  def self.generate_list num
    questions = self.process_questions
    question_impressions = self.process_impressions
  end

  def self.process_questions
    questions = []
    CSV.foreach('./data/questions.csv', headers: true) do |row|
      questions << Question.new(
        strand_id: row["strand_id"].to_i,
        strand_name: row["strand_name"],
        standard_id: row["standard_id"].to_i,
        standard_name: row["standard_name"],
        question_id: row["question_id"].to_i,
        difficulty: row["difficulty"].to_f
      )
    end
    questions
    #questions.each { |q| puts q.inspect } 
  end

  def self.process_impressions
    question_impressions = []
    CSV.foreach('./data/usage.csv', headers: true) do |row|
      question_impressions << QuestionImpression.new(
        student_id: row["student_id"].to_i,
        question_id: row["question_id"].to_i,
        assigned_hours_ago: row["assigned_hours_ago"].to_i,
        answered_hours_ago: row["answered_hours_ago"].nil? ? nil : row["answered_hours_ago"].to_i
      )
    end
    question_impressions
    #question_impressions.each { |q| puts q.inspect } 
  end
end
