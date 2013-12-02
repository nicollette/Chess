require_relative 'piece'

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
    dx, dy = move_dir
    cur_x, cur_y = @position

    while true
      cur_x, cur_y = cur_x + dx, cur_y + dy
      new_pos = [cur_x, cur_y]
      break unless board.within_bounds?(cur_x, cur_y)
      
      if board[new_pos].nil?
        one_direction_moves << new_pos
      else
        one_direction_moves << new_pos if board[new_pos].color != @color
     
        break
      end
    end

    one_direction_moves
  end
  
  private
  def move_dirs
    raise NotImplementedError
  end
end
