class Board
  attr_accessor :diagonals
  attr_reader :size, :matrix
  attr_writer :free_cells

  def initialize(size)
    size = 3 if size < 3 || size > 31

    @size = size
    @matrix = []
    @free_cells = true
    @diagonals = { primary: [], secundary: [] }
  end

  def free_cells?
    @free_cells
  end

  def fill_matrix
    size.times do |i|
      matrix.push([])
      size.times { |j| create_cell(i, j) }
    end
    set_diagonals
  end

  def create_cell(x_index, y_index)
    c = x_index * size + y_index + 1
    matrix[x_index][y_index] = Cell.new(c, format('%03d', c))
  end

  def print_matrix
    size.times do |i|
      top_and_bottom_lines(size * 8 + 1)
      before_and_after_lines
      numbers_line(i)
      before_and_after_lines
    end
    top_and_bottom_lines(size * 8 + 1)
  end

  private

  attr_writer :matrix

  def set_diagonals
    diagonals[:primary] = []
    diagonals[:secundary] = []
    capture_diagonals
  end

  def capture_diagonals
    size.times do |index|
      add_cells(index)
    end
  end

  def add_cells(index)
    diagonals[:primary].push(matrix[index][index])
    diagonals[:secundary].push(matrix[(size - 1) - index][index])
  end

  def top_and_bottom_lines(columns)
    line = ''
    columns.times { line += '=' }
    puts line
  end

  def before_and_after_lines
    line = ''
    size.times { line += '|       ' }
    puts line += '|'
  end

  def numbers_line(index)
    line_of_numbers = ''
    size.times { |j| line_of_numbers += "|  #{matrix[index][j].label}  " }
    puts line_of_numbers += '|'
  end
end
