class QuestionImpression
  attr_accessor :student_id, :question_id, :assigned_hours_ago, :answered_hours_ago

  def initialize(attrs)
    @student_id = attrs[:student_id]
    @question_id = attrs[:question_id]
    @assigned_hours_ago = attrs[:assigned_hours_ago]
    @answered_hours_ago = attrs[:answered_hours_ago]
  end
end
