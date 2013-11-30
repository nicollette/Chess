# encoding: utf-8
require_relative 'piece'

class Pawn < Piece
  attr_accessor :unicode_char, :position

  # probably don't need to have the second element, can just
  # increment twice

  #don't even need these constatns, have a method called FORWARD_DIR
  # like Ned, that returns -1 || 1 depending on color
  STRAIGHTS = [   [ 1,  0],
                  [ 2,  0]]

  DIAGONALS = [     [ 1,  1],
                    [ 1, -1]]
  #can
  INVERTED_STRAIGHTS = [   [ -1, 0],
                           [ -2, 0]]

  INVERTED_DIAGONALS = [[ -1,  -1],
                        [ -1,   1]]

  def initialize(board, position, color)
    super(board, position, color)
    @straights = STRAIGHTS
    @diagonals = DIAGONALS
    @unicode_char
    direction_setter
  end

  def unicode_char
    { :black => "♟", :white => "♙" }
  end

  # refactor this MOVES method
  def moves
    possible_moves = []

    x = @position[0]
    y = @position[1]

    unless blocked?(x, y)
      possible_moves << [x + @straights[0][0], y]
      if jump?(x,y)
        possible_moves << [x +@straights[1][0], y]
      end
    end
    possible_moves.concat(eat_diagonals(x,y))
  end

  def direction_setter
    if @color == :white
      @straights = INVERTED_STRAIGHTS
      @diagonals = INVERTED_DIAGONALS
    end
  end

  def blocked?(x, y)
    forward_one = @straights[0]
    !board.grid[x + forward_one[0]][y].nil?
  end

  def jump?(x,y)
    forward_two = @straights[1]
    board.grid[x + forward_two[0]][y].nil?
  end

  def eat_diagonals(x,y)
    diagonal_moves = []
    @diagonals.each do |diagonal|
      next if board.grid[x+diagonal[0]][y+diagonal[1]].nil?
      unless board.grid[x+diagonal[0]][y+diagonal[1]].color == @color
        diagonal_moves << [x+diagonal[0],y+diagonal[1]]
      end
    end
    diagonal_moves
  end
end

