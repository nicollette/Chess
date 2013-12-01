# encoding: utf-8
require_relative 'slidingpieces'

class Bishop < SlidingPieces
  def move_dirs
    [ [ 1,  1],
      [ 1, -1],
      [-1, -1],
      [-1,  1] ]
  end

  def unicode_char
    { :black => "♝", :white => "♗" }
  end
end