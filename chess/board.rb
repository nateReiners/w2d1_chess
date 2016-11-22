require_relative "piece"
require_relative "null_piece"

class Board
  NULL_PIECE = NullPiece.new
  attr_reader :grid

  def default_grid
    Array.new(8) { Array.new(8, nil) }
  end

  def initialize(grid = default_grid)
    @grid = grid
  end

  def move_piece(start_pos, end_pos)
    @grid[end_pos[0]][end_pos[1]] = @grid[start_pos[0]][start_pos[1]]
    @grid[start_pos[0]][start_pos[1]] = NULL_PIECE
  end

  def populate
    rows_to_popuplate = [0, 1, @grid.length - 2, @grid.length - 1]

    @grid.each_with_index do |row, idx1|

      if rows_to_popuplate.include?(idx1)
        row.each_with_index do |el, idx2|
          @grid[idx1][idx2] = Piece.new([idx1, idx2])
        end
      else
        row.each_with_index do |el, idx2|
          @grid[idx1][idx2] = NULL_PIECE
        end
      end
    end

    @grid
  end

end

b = Board.new
b.populate

p b.grid[0][0]
b.move_piece([0,0], [1,1])
p b.grid[1][1]
p b.grid[0][0]
