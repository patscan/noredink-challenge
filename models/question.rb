class Question
  attr_accessor :strand_id, :strand_name, :standard_id, :standard_name, 
    :question_id, :difficulty

  def initialize attrs
    @strand_id = attrs[:strand_id]
    @strand_name = attrs[:strand_name]
    @standard_id = attrs[:standard_id]
    @standard_name = attrs[:standard_name]
    @question_id = attrs[:question_id]
    @difficulty = attrs[:difficulty]
  end
end
