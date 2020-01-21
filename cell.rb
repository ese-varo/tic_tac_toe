class Cell
  attr_accessor :label
  attr_reader :id_number
  attr_writer :is_free

  def initialize(id_number, label)
    @id_number = id_number
    @label = label
    @is_free = true
  end

  def is_free?
    @is_free
  end
end