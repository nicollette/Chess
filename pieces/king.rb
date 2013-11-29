# encoding: utf-8
require_relative 'steppingpieces'

class King < SteppingPieces
  def move_dir
    STRAIGHTS + DIAGONALS
  end

  def render_unicode
    @unicode_char = @color == "black" ? "♚" : "♔"
  end
end

# Ned has MOVE_DIFFS method instead of MOVE_DIR, which returns
# exact array of move_directions
# I think Ned's way is clearer