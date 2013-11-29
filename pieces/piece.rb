class Piece
  attr_reader :color, :board
  attr_accessor :unicode_char, :position

  STRAIGHTS = [
    [ 0,  1],
    [ 1,  0],
    [-1,  0],
    [ 0, -1]
  ]

  DIAGONALS = [
    [ 1,  1],
    [ 1, -1],
    [-1, -1],
    [-1,  1]
  ]

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color
    @unicode_char # doesn't have this instance VAR

    #Ned's solution calls a board.add_piece method that assigns
    # self to a postition on the board
    # so that all pieces that are created are automatically
    #assigned to the board
  end

  def moves
    raise NotImplimentedError
  end

  def render
    unicode_char[color]
  end

  def unicode_char
    raise NotImplementedError
  end

  def valid_moves
    moves.reject { |possible_move| move_into_check?(possible_move) }
  end

  def move_into_check?(move)
    duped_board = board.dup
    duped_board.move!(position, move)
    duped_board.in_check?(color)
  end

end

