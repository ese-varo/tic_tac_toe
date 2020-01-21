class Board
  attr_reader :size, :matrix
  attr_writer :free_cells

  def initialize(size)
    size = 3 if size < 3 || size > 31

    @size = size
    @matrix = []
    @free_cells = true
    @line_status = []
  end

  def free_cells?
    @free_cells
  end

  def fill_matrix
    c = 1
    size.times do |i|
      matrix.push([])
      size.times do |j|
        cell = Cell.new(c, "%03d"%c)
        matrix[i][j] = cell 
        c += 1
      end
    end
  end

  private 

  attr_writer :matrix

end