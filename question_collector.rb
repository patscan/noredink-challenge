require 'CSV'
require './models/question'
require './models/question_impression'

class QuestionCollector
  def self.generate_list num
    num = num.to_i
    questions = self.process_questions
    question_impressions = self.process_impressions
    best_questions = self.choose_best_questions(questions, question_impressions, num.to_i)
    best_questions.map(&:question_id)
  end

  def self.choose_best_questions questions, question_impressions, num
    # Currently, this naively orders by difficulty only without any accounting 
    # for strand or standard. Ideally, this would implement a round robin sort using those attributes
    # before grabbing the result set.
    result_list = []
    if num > questions.length
      until questions.length >= num
        questions = questions + questions
      end
    end
    questions_ordered_by_ease = questions.sort_by {|q| q.difficulty }.reverse
    questions_ordered_by_ease.take(num)
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
  end
end
