class Player
  attr_accessor :name
  attr_reader :symbol
  attr_writer :turn

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @turn = false
  end

  def turn?
    @turn
  end
end
