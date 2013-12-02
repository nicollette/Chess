# encoding: utf-8
require_relative 'piece'

class Pawn < Piece
  attr_accessor :unicode_char, :position

  def unicode_char
    { :black => "♟", :white => "♙" }
  end

  def moves
    forward_moves + side_moves
  end

  private
  def at_start_pos?
    start_row = color == :black ? 1 : 6
    @position[0] == start_row
  end
  
  def forward_dir
    (color == :black ) ? 1 : -1
  end
  
  def forward_moves
    moves = []
    
    x, y = @position
    one_step = [x + forward_dir, y]
    
    if board.within_bounds?(one_step[0], one_step[1]) && board[one_step].nil?
      moves << one_step
      
      two_step = [x + (2 * forward_dir), y]
      if at_start_pos? && board[two_step].nil?
        moves << two_step
      end
    end
    moves
  end
  
  def side_moves
    x, y = @position
    
    side_moves = [[x + forward_dir, y - 1], [x + forward_dir, y + 1]]
    
    side_moves.select do |dx, dy|
      next false unless board.within_bounds?(dx, dy)
      new_pos = [dx, dy]
      vulnerable_piece = board[new_pos]
      vulnerable_piece && vulnerable_piece.color != @color
    end
  end
end

