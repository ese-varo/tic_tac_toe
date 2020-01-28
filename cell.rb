class Cell
  attr_accessor :label
  attr_reader :id_number
  attr_writer :free

  def initialize(id_number, label)
    @id_number = id_number
    @label = label
    @free = true
  end

  def free?
    @free
  end
end
