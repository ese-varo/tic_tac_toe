require_relative 'board'
require_relative 'cell'
require_relative 'player'

def start_game(players, trackers)
  board = create_board
  board.fill_matrix
  players[:player1] = add_player(' X ', 'first')
  players[:player2] = add_player(' O ', 'second')
  players[:player1].turn = true
  sleep 1
  new_match(board, players, trackers)
end

def new_match(board, players, trackers)
  while board.free_cells? && !trackers[:winner]
    new_round(board, players, trackers)
    board.free_cells = false unless trackers[:counter] < board.size**2
  end
  continue_playing(board, players, trackers)
end

def new_round(board, players, trackers)
  print_turn(board)
  next_move(board, players, trackers)
  print_turn(board)
  trackers[:counter] += 1
  there_a_winner(board, trackers) if trackers[:counter] >= (board.size * 2 - 1)
end

def continue_playing(board, players, trackers)
  if trackers[:winner]
    puts "Congratulations #{winner(players, trackers)}!! You are the winner!!"
  else
    puts 'Draw!!'
  end
  play_again(board, players, trackers)
end

def winner(players, trackers)
  trackers[:last_winner] = if players[:player1].turn?
                             players[:player2].name
                           else
                             players[:player1].name
                           end
end

def play_again(board, players, trackers)
  puts 'Do you want to play again? y/n'
  continue_playing = gets.chomp.downcase
  if continue_playing == 'y'
    set_default_values(board, trackers)
    new_match(board, players, trackers)
  else
    bye_message
  end
end

def set_default_values(board, trackers)
  trackers[:winner] = false
  trackers[:counter] = 0
  board.free_cells = true
  board.fill_matrix
end

def bye_message
  puts 'Thanks for playing, see you soon!!'
  sleep 1
end

def there_a_winner(board, trackers)
  diagonal_cell = inside_diagonal(board, trackers)
  validate_diagonal(board, trackers, diagonal_cell) if diagonal_cell
  validate_vertical(board, trackers)
  validate_horizontal(board, trackers)
end

def same_symbol?(board, trackers, index)
  symbol1 = board.matrix[trackers[:x]][trackers[:y]].label
  symbol2 = board.matrix[index[:x]][index[:y]].label
  symbol1 == symbol2
end

def validate_vertical(board, trackers)
  index = { x: 0, y: trackers[:y] }
  while index[:x] < board.size && same_symbol?(board, trackers, index)
    index[:x] += 1
  end
  trackers[:winner] = true if index[:x] == board.size
end

def validate_horizontal(board, trackers)
  index = { x: trackers[:x], y: 0 }
  while index[:y] < board.size && same_symbol?(board, trackers, index)
    index[:y] += 1
  end
  trackers[:winner] = true if index[:y] == board.size
end

def validate_diagonal(board, trackers, diagonal)
  board.diagonals[diagonal.to_sym].each do |cell|
    return unless cell.label == board.matrix[trackers[:x]][trackers[:y]].label
  end
  trackers[:winner] = true
end

def inside_diagonal(board, trackers)
  cell = board.matrix[trackers[:x]][trackers[:y]]
  primary = board.diagonals[:primary]
  secundary = board.diagonals[:secundary]
  return 'primary' if primary.include?(cell)
  return 'secundary' if secundary.include?(cell)

  false
end

def next_move(board, players, trackers)
  if players[:player1].turn?
    who_next(players[:player1], board, trackers)
    players[:player1].turn = false
    players[:player2].turn = true
  else
    who_next(players[:player2], board, trackers)
    players[:player1].turn = true
    players[:player2].turn = false
  end
end

def add_player(symbol, which_player)
  puts "Please enter the name of the #{which_player} player"
  player = Player.new(gets.chomp, symbol)
  puts "Hi #{player.name}! your symbol is#{player.symbol}"
  player
end

def create_board
  puts 'Please enter the number of columns to create board'
  Board.new(gets.chomp.to_i)
end

def who_next(player, board, trackers)
  select_cell(player, board, trackers)
  if valid_selection?(board, trackers)
    asign_symbol(player, board, trackers)
  else
    print_turn(board)
    who_next(player, board, trackers)
  end
end

def select_cell(player, board, trackers)
  puts "#{player.name} please enter the number of a free cell!"
  trackers[:selected_cell] = gets.chomp.to_i
  trackers[:x] = x_position(trackers[:selected_cell], board.size)
  trackers[:y] = y_position(trackers[:selected_cell], board.size)
end

def asign_symbol(player, board, trackers)
  board.matrix[trackers[:x]][trackers[:y]].is_free = false
  board.matrix[trackers[:x]][trackers[:y]].label = player.symbol
end

def print_turn(board)
  system 'clear'
  board.print_matrix
end

def valid_selection?(board, trackers)
  if trackers[:selected_cell] > board.size**2 || trackers[:selected_cell] < 1
    false
  else
    board.matrix[trackers[:x]][trackers[:y]].is_free?
  end
end

def x_position(cell, size)
  (cell - 1) / size
end

def y_position(cell, size)
  (cell - 1) % size
end

trackers = { counter: 0, winner: false, last_winner: '',
             x: nil, y: nil, selected_cell: nil }
players = { player1: nil, player2: nil }

start_game(players, trackers)
