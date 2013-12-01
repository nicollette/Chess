require_relative 'piece'

class SteppingPieces < Piece
  def moves
    possible_moves = []

    move_dirs.each do |x, y|
      cur_x, cur_y = @position
      new_pos = [cur_x + x, cur_y + y]

      next unless board.within_bounds?(new_pos[0], new_pos[1])

      if board[new_pos].nil?
        possible_moves << new_pos
      elsif board[new_pos].color != @color
        possible_moves << new_pos
      end
    end
    possible_moves
  end
end