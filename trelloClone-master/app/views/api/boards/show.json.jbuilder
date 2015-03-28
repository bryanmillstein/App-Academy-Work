# write some jbuilder to return some json about a board
# it should include the board
#  - its lists
#    - the cards for each list

json.extract! @board, :title

json.lists @board.lists do |list|
  json.extract! list, :title

  json.cards list.cards do |card|
    json.extract! card, :title
  end
end
