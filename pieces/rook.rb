# encoding: utf-8
require_relative 'slidingpieces'

class Rook < SlidingPieces
  def move_dirs
    STRAIGHTS
  end

  def unicode_char
    { :black => "♜", :white => "♖" }
  end
end