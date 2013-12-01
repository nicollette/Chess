require_relative 'piece'

class SteppingPieces < Piece
  def moves
    possible_moves = []

    move_dirs.each do |move_dir|
      x = @position[0] + move_dir[0]
      y = @position[1] + move_dir[1]

      next unless board.within_bounds?(x, y)

      if board.grid[x][y].nil?
        possible_moves << [x, y]
      elsif board.grid[x][y].color != @color
        possible_moves << [x, y]
      end
    end
    possible_moves
  end
end

# Ned has a move_diffs method that returns an array of move directions
# the MOVE_DIFFS method is defined here but must be IMPLEMENTED on sub
# class level