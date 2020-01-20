class Player
  attr_accessor :name, :turn
  attr_reader :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @turn = false
  end
end