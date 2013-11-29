# encoding: utf-8
require_relative 'steppingpieces'

class Knight < SteppingPieces

  def move_dir
    [
        [-2, -1],
        [-2,  1],
        [-1, -2],
        [-1,  2],
        [ 1, -2],
        [ 1,  2],
        [ 2, -1],
        [ 2,  1]
    ]
  end

  def unicode_char
    { "black" => "♞", "white" => "♘" }
  end
end

# Ned has MOVE_DIFFS method instead of MOVE_DIR, which returns
# exact array of move_directions
# I think Ned's way is clearer