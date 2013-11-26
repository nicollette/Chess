class Piece

  attr_reader :position, :color

  def initialize(grid, postion, color)
    @grid = grid
    @position = position
    @color = color
  end

  def moves
    raise NotImplimented
  end

  def valid_move?


  end

end

