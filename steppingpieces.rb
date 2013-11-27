require "./piece.rb"

class SteppingPieces < Piece

  def move
    possible_moves = []

    @move_dirs.each do |move_dir|
      x = @position[1] + move_dir[1]
      y = @position[0] + move_dir[0]

      next unless @grid.within_bounds?(x, y)

      if grid[x][y].empty?
        possible_moves << [x, y]
      elsif grid[x][y].color != @color
        possible_moves << [x, y]
      end
    end
    possible_moves
  end

end

class Knight < SteppingPieces
  def move_dir
    [  [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]]
  end
end

class King < SteppingPieces
  def move_dir
    STRAIGHTS + DIAGONALS
  end
end
