require_relative "board"
require_relative "cell"
require_relative "player"

def start_game
  trackers = {counter: 0, winner: false, last_winner: ""}
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
    next_move(board, player1, player2)
    print_turn(board)
    trackers[:counter] += 1
    board.free_cells = false unless trackers[:counter] < board.size** 2
  end
  continue_playing?
end

def continue_playing?
  puts "Empate!!"
end

def next_move(board, player1, player2)
  if player1.turn?
    who_next?(player1, board)
    player1.turn, player2.turn = false, true
  else
    who_next?(player2, board)
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

def who_next?(player, board)
  selected_cell = select_cell(player)
  if valid_selection?(selected_cell, board)
    asign_symbol(player, board, selected_cell)
  else
    print_turn(board)
    who_next?(player, board)
  end
end

def select_cell(player)
  puts "#{player.name} please enter the number of a free cell!"
  gets.chomp.to_i
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

start_game