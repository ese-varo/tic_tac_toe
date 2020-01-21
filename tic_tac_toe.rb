require_relative "board"
require_relative "cell"
require_relative "player"

puts "Please enter the number of columns to create board"
board = Board.new(gets.chomp.to_i)
puts "Please enter the name of the first player"
player1 = Player.new(gets.chomp, " X ")
player1.turn = true
puts "Hi #{player1.name}! your symbol is#{player1.symbol}"
puts "Please enter the name of the second player"
player2 = Player.new(gets.chomp, " O ")
puts "Hi #{player2.name}! your symbol is#{player2.symbol}"

sleep 2

board.fill_matrix
counter = 0
winner = false
last_winner = 0

def who_next?(player, board)
  puts "#{player.name} please enter the number of a free cell!"
  selected_cell = gets.chomp.to_i
  if valid_selection?(selected_cell, board)
    asign_symbol(player, board, selected_cell)
  else
    print_turn(board)
    who_next?(player, board)
  end
end

def asign_symbol(player, board, cell)
  board.matrix[x_position(cell, board)][y_position(cell, board)].is_free = false
  board.matrix[x_position(cell, board)][y_position(cell, board)].label = player.symbol
end

def print_turn(board)
  system "clear"
  board.print_matrix
end

def valid_selection?(cell, board)
  board.matrix[x_position(cell, board)][y_position(cell, board)].is_free?
end

def x_position(cell, board)
  (cell - 1) / board.size
end

def y_position(cell, board)
  (cell - 1) % board.size
end

while board.free_cells? && !winner 
  print_turn(board)
  if player1.turn?
    who_next?(player1, board)
    player1.turn, player2.turn = false, true
    # player2.turn = true
  else
    who_next?(player2, board)
    player2.turn, player1.turn = false, true
    # player2.turn = false
    # player1.turn = true
  end

  print_turn(board)
  counter += 1
  board.free_cells = false unless counter <= board.size** 2
end