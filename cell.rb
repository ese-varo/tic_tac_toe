class Cell
  attr_accessor :label
  attr_reader :id_number

  def initialize(id_number, label)
    @id_number = id_number
    @label = label
  end
end