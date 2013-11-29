# encoding: utf-8
require_relative 'steppingpieces'

class King < SteppingPieces
  def move_dir
    STRAIGHTS + DIAGONALS
  end

  def unicode_char
    { "black" => "♚", "white" => "♔" }
  end

end

# Ned has MOVE_DIFFS method instead of MOVE_DIR, which returns
# exact array of move_directions
# I think Ned's way is clearer