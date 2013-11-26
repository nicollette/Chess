class Board

  def initialize
    @grid = Array.new(8) {Array.new(8)}
  end

  def set_up
  end

  def empty?(position)
    @grid[postion[1]position[0]]
  end

  def to_s
  end

  def within_bounds?(x, y)
    [x, y].min >= 0 && [x, y].max < 8
  end

end