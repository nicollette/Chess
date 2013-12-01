# encoding: utf-8
require_relative 'steppingpieces'

class King < SteppingPieces
  def move_dirs
    [ [ 0,  1],
      [ 1,  0],
      [-1,  0],
      [ 0, -1],
      [ 1,  1],
      [ 1, -1],
      [-1, -1],
      [-1,  1] ]
  end

  def unicode_char
    { :black => "♚", :white => "♔" }
  end

end