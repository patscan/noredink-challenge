require './question_collector'

puts "How many questions would you like in your quiz?"
num = gets.chomp 
puts "Great, I'll generate a list of #{num} question IDs, hang on..."
QuestionCollector.generate_list num
