require './piece.rb'

class SlidingPieces < Piece
  # def initialize(grid, postion, color)
  #   super(grid, position, color)
  # end


  def moves

    possible_moves = []

    @move_dirs.each do |move_dir|
      # CALL CHECK_DIR ON EACH MOVE_DIR
      possible_moves << single_direction_moves(move_dir)
    end

  end


  def single_direction_moves(move_dir)
    one_direction_moves = []
    x = @position[1] + move_dir[1]
    y = @position[0] + move_dir[0]

    while @grid[x][y].empty? && @grid.within_bounds?(x, y)
      one_direction_moves << [x, y]
      x += move_dir[1]
      y += move_dir[0]
    end

    # Checks if one move more contains a piece of opposite color

    unless @grid[x][y].color == @color
      one_direction_moves << [x, y]
    end

    one_direction_moves
  end

end


class Rook < SlidingPieces
  # def initialize
  #   super
  # end
  @move_dirs = [  [ 0,  1],
                  [ 1,  0],
                  [-1,  0],
                  [ 0, -1]]

end

class Bishop < SlidingPieces
  # def initialize
  #   super
  # end
  @move_dirs = [  [ 1,  1],
                  [ 1, -1],
                  [-1, -1],
                  [-1,  1]]


end


class Queen < SlidingPieces
  # def initialize
  #   super
  # end
  @move_dirs = [  [ 0,  1],
                  [ 1,  0],
                  [-1,  0],
                  [ 0, -1],
                  [ 1,  1],
                  [ 1, -1],
                  [-1, -1],
                  [-1,  1]]


end
