# encoding: utf-8
require_relative 'steppingpieces'

class Knight < SteppingPieces

  def move_dirs
    [ [-2, -1],
      [-2,  1],
      [-1, -2],
      [-1,  2],
      [ 1, -2],
      [ 1,  2],
      [ 2, -1],
      [ 2,  1] ]
  end

  def unicode_char
    { :black => "♞", :white => "♘" }
  end
end