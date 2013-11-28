# encoding: utf-8
require './piece.rb'

class SlidingPieces < Piece

  def moves
    possible_moves = []

    move_dirs.each do |move_dir|
      possible_moves.concat(single_direction_moves(move_dir))
    end
    possible_moves
  end

  def single_direction_moves(move_dir)
    one_direction_moves = []
    x = @position[0] + move_dir[0]
    y = @position[1] + move_dir[1]

   while @board.within_bounds?(x, y)

      if @board.grid[x][y].nil?
        one_direction_moves << [x, y]
      elsif @board.grid[x][y].color  == @color
        break
      elsif @board.grid[x][y].color != @color
        one_direction_moves << [x, y]
        x = -9 #setting piece out of bound to break loop
      end
      y += move_dir[1]
      x += move_dir[0]
    end

    one_direction_moves
  end
end


class Rook < SlidingPieces
  def move_dirs
    STRAIGHTS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♜" : "♖"
  end
end

class Bishop < SlidingPieces
  def move_dirs
    DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♝" : "♗"
  end
end


class Queen < SlidingPieces
  def move_dirs
    STRAIGHTS + DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♛" : "♕"
  end
end
