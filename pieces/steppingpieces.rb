# require './piece.rb'
require_relative 'piece'

class SteppingPieces < Piece
  def moves
    possible_moves = []

    move_dir.each do |move_dir|
      y = @position[1] + move_dir[1]
      x = @position[0] + move_dir[0]

      next unless @board.within_bounds?(x, y)

      if @board.grid[x][y].nil?
        possible_moves << [x, y]
      elsif @board.grid[x][y].color != @color
        possible_moves << [x, y]
      end
    end
    possible_moves
  end
end