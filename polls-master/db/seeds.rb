# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  users = User.create([{name: 'Bob'},
                      {name: 'Jerry'}])

  polls = Poll.create([{title: 'Sleep', author_id: 1 },
                      {title: 'Diet', author_id: 2}])

  questions = Question.create([{text: 'How many hours?', poll_id: 1},
                              {text: 'Bed at what time?', poll_id: 1},
                              {text: 'How many calories per day?', poll_id: 2},
                              {text: 'Sweets?', poll_id: 2}])

  answer_choices = AnswerChoice.create([{text: 'Less than 8', question_id: 1},
                                       {text: 'More than 8', question_id: 1},
                                       {text: 'Before 10PM', question_id: 2},
                                       {text: 'After 10PM', question_id: 2},
                                       {text: 'More than 2000', question_id: 3},
                                       {text: 'Less than 2000', question_id: 3},
                                       {text: 'Many', question_id: 4},
                                       {text: 'Few', question_id: 4}])
