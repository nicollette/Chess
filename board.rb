# encoding: utf-8
require './pawn.rb'
require './steppingpieces.rb'
require './slidingpieces.rb'

class Board

  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8)}
    set_up_pawns
    set_up_others
  end

  def set_up_pawns
    [1, 6].each do |row|
      color = row == 1 ? "black" : "white"
      @grid[row].each_index do |col|
        @grid[row][col] = Pawn.new(self, [row, col], color)
      end
    end
  end

  BACKROW_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  def set_up_others
    [0, 7].each do |row|
      color = row == 0 ? "black" : "white"
      BACKROW_PIECES.each_with_index do |piece, col|
        @grid[row][col] = piece.new(self, [row, col], color)
      end
    end
  end

  def within_bounds?(x, y)
    [x, y].min >= 0 && [x, y].max < 8
  end

  def display_grid
    puts "   0 1 2 3 4 5 6 7"
    puts
    @grid.each_with_index do |row, index|
      print "#{index}  "
      row.each do |tile|
        if tile.nil?
          print "_ "
        else
        print "#{tile.render_unicode} "
        end
      end
      puts
    end
  end

  def in_check?(color)
    king_position = find_king_pos(color)
    return true if possible_opposing_moves(color).include?(king_position)
  end

  def find_king_pos(color)
    @grid.each do |row|
      row.each do |tile|
        return tile.position if (tile.is_a?(King) && tile.color == color)
      end
    end
  end

  def possible_opposing_moves(color)
    selected_array_pieces = pieces.select do |piece|
      piece.color != color
    end

    possible_moves = selected_array_pieces.inject([]) do |result, piece|
      result.concat(piece.moves)
    end

    possible_moves.uniq
  end

  def pieces
    @grid.flatten.compact
  end
end

if $PROGRAM_NAME == __FILE__
new_board = Board.new
# new_board.find_king_pos("black").position
new_board.possible_opposing_moves("white")
pawn1 = King.new(new_board, [2,3], "white")
new_board.grid[2][3] = pawn1
# new_board.grid[0][6].moves
#
# new_board.grid[1][6].moves
# p new_board.grid[2][3].moves
p new_board.in_check?("black")
new_board.display_grid

end