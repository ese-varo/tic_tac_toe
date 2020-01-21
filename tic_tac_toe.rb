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
system "clear"

board.fill_matrix
board.print_matrix

cell = 1
i = (cell - 1) / board.size 
j = (cell - 1) % board.size