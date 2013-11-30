# encoding: utf-8
require_relative 'slidingpieces'

class Queen < SlidingPieces
  def move_dirs
    STRAIGHTS + DIAGONALS
  end

  def unicode_char
    { :black => "♛", :white => "♕"}
  end
end