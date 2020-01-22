require_relative "board"
require_relative "cell"
require_relative "player"

def start_game
  trackers = {counter: 0, winner: false, last_winner: "", x: nil, y: nil, selected_cell: nil}
  board = create_board
  board.fill_matrix
  player1 = add_player(" X ", "first")
  player2 = add_player(" O ", "second")
  player1.turn = true
  sleep 2
  new_match(board, player1, player2, trackers)
end

def new_match(board, player1, player2, trackers)
  while board.free_cells? && !trackers[:winner]
    print_turn(board)
    next_move(board, player1, player2, trackers)
    print_turn(board)
    trackers[:counter] += 1
    is_there_a_winner?(board, player1, player2, trackers) if trackers[:counter] >= (board.size * 2 - 1)
    board.free_cells = false unless trackers[:counter] < board.size** 2
  end
  continue_playing?(board, player1, player2, trackers)
end

def continue_playing?(board, player1, player2, trackers)
  if trackers[:winner]
    puts "Congratulations #{who_is_the_winner?(board, player1, player2)}!! You are the winner!!"
  else
    puts "Draw!!"
  end
  play_again?
end

def who_is_the_winner?(board, player1, player2)
  player1.turn? ? "#{player2.name}" : "#{player1.name}"
end

def play_again?
  puts "Play again?"
end

def is_there_a_winner?(board, player1, player2, trackers)
  is_a_diagonal_cell = falls_in_diagonal?(board, trackers) 
  validate_diagonal(board, trackers, is_a_diagonal_cell) if is_a_diagonal_cell
  validate_vertical(board, trackers)
  validate_horizontal(board, trackers)
end

def validate_vertical(board, trackers)
  x = 0
  while x < board.size && board.matrix[x][trackers[:y]].label == board.matrix[trackers[:x]][trackers[:y]].label 
    x += 1
  end
  trackers[:winner] = true if x == board.size
end

def validate_horizontal(board, trackers)
  y = 0
  while y < board.size && board.matrix[trackers[:x]][y].label == board.matrix[trackers[:x]][trackers[:y]].label 
    y += 1
  end
  trackers[:winner] = true if y == board.size
end

def validate_diagonal(board, trackers, diagonal)
  board.diagonals[diagonal.to_sym].each do |cell|
    return unless cell.label == board.matrix[trackers[:x]][trackers[:y]].label
  end
  trackers[:winner] = true
end

def falls_in_diagonal?(board, trackers)
  cell = board.matrix[trackers[:x]][trackers[:y]] 
  primary = board.diagonals[:primary]
  secundary = board.diagonals[:secundary]
  return "primary" if primary.include?(cell)
  return "secundary" if secundary.include?(cell)
  false
end

def next_move(board, player1, player2, trackers)
  if player1.turn?
    who_next?(player1, board, trackers)
    player1.turn, player2.turn = false, true
  else
    who_next?(player2, board, trackers)
    player2.turn, player1.turn = false, true
  end
end

def add_player(symbol, which_player)
  puts "Please enter the name of the #{which_player} player"
  player = Player.new(gets.chomp, symbol)
  puts "Hi #{player.name}! your symbol is#{player.symbol}"
  player
end

def create_board
  puts "Please enter the number of columns to create board"
  Board.new(gets.chomp.to_i)
end

def who_next?(player, board, trackers)
  select_cell(player, board, trackers)
  if valid_selection?(board, trackers)
    asign_symbol(player, board, trackers)
  else
    print_turn(board)
    who_next?(player, board, trackers)
  end
end

def select_cell(player, board, trackers)
  puts "#{player.name} please enter the number of a free cell!"
  trackers[:selected_cell] = gets.chomp.to_i
  trackers[:x] = x_position(trackers[:selected_cell], board)
  trackers[:y] = y_position(trackers[:selected_cell], board)
end

def asign_symbol(player, board, trackers)
  board.matrix[trackers[:x]][trackers[:y]].is_free = false
  board.matrix[trackers[:x]][trackers[:y]].label = player.symbol
end

def print_turn(board)
  system "clear"
  board.print_matrix
end

def valid_selection?(board, trackers)
  if trackers[:selected_cell] > board.size** 2 || trackers[:selected_cell] < 1
    return false
  else
    board.matrix[trackers[:x]][trackers[:y]].is_free?
  end
end

def x_position(cell, board)
  (cell - 1) / board.size
end

def y_position(cell, board)
  (cell - 1) % board.size
end

start_game