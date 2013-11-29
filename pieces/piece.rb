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
    raise NotImplimented
  end

  # Ned has a render method that calls a symbols method
    #Symbols method take a color and must be implemented in each
    # sub class to display unicode char

  # Ned has helper method for VALID_MOVES, called MOVE_INTO_CHECK?
  # each possible move is passed in and does lines 44-46, except
  # doesn't add to valid moves arr
  #
  #VALID_MOVES method only takes the moves that return false to
  # MOVE_INTO_CHECK
  def valid_moves
    valids = []
    moves.each do |possible_move|
      duped_board = board.dup
      duped_board.move!(@position, possible_move)
      valids << possible_move unless duped_board.in_check?(@color)
    end
    valids
  end

end

