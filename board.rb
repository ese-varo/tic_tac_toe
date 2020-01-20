class Board
  def initialize(size)
    size = 3 if size < 3 || size > 999

    @size = size
    @board_matrix = [][]
    @free_cells = true
    @line_status = []
  end
end