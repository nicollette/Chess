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

# def empty?(position)
#   @grid[postion[1]][position[0]].nil?
# end

def to_s
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

end

if $PROGRAM_NAME == __FILE__
new_board = Board.new
new_board.display_grid
p new_board.grid[1][1].moves
p new_board.grid[0][0].moves
end