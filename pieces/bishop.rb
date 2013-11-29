# encoding: utf-8
require_relative 'slidingpieces'

class Bishop < SlidingPieces
  def move_dirs
    DIAGONALS
  end

  def unicode_char
    { "black" => "♝", "white" => "♗" }
  end
end