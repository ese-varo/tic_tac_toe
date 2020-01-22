class Board
  attr_accessor :diagonals
  attr_reader :size, :matrix
  attr_writer :free_cells

  def initialize(size)
    size = 3 if size < 3 || size > 31

    @size = size
    @matrix = []
    @free_cells = true
    @diagonals = {primary: [], secundary: []}
  end

  def free_cells?
    @free_cells
  end

  def fill_matrix
    size.times do |i|
      matrix.push([])
      size.times do |j|
        c = i * size + j + 1
        matrix[i][j] = Cell.new(c, "%03d"%c)
      end
    end
    capture_diagonals
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

  def capture_diagonals
    size.times do |index| 
      diagonals[:primary].push(matrix[index][index])
      diagonals[:secundary].push(matrix[(size - 1) - index][index])
    end
  end

  def top_and_bottom_lines(n)
    line = ""
    n.times { line += "=" }
    puts line
  end

  def before_and_after_lines
    line = ""
    size.times { line += "|       "}
    puts line += "|"
  end

  def numbers_line(index)
    line_of_numbers = ""
    size.times { |j| line_of_numbers += "|  #{matrix[index][j].label}  " }
    puts line_of_numbers += "|"
  end

end