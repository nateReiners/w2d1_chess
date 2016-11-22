require 'colorize'
require_relative "board"
require_relative "cursor"

class Display
  attr_reader :board, :cursor

  def initialize
    @cursor = Cursor.new([0,0], board = Board.new)
    @board = board
  end

  def render
    stringy_board = "  "
    (0..7).to_a.each { |el| stringy_board << "#{el} " }
    stringy_board << "\n"


    @board.grid.each_with_index do |row, idx|
      stringy_board << "#{idx} "
      row.each_with_index do |el, idx2|
        if @cursor.cursor_pos == [idx, idx2]
          if el.is_a?(NullPiece)
            stringy_board << "_ ".colorize(:color => :white, :background => :black)
          elsif el.is_a?(Piece)
            stringy_board << "P ".colorize(:color => :white, :background => :black)
          end
        else
          if el.is_a?(NullPiece)
            stringy_board << "_ "
          elsif el.is_a?(Piece)
            stringy_board << "P "
          end
        end

      end
      stringy_board << "\n"
    end
    puts stringy_board
  end

  def test_cursor
    5.times do
      p @cursor.cursor_pos
      render
      @cursor.get_input
    end
  end

end


# x = Display.new
# x.board.populate
# x.render
# x.test_cursor
