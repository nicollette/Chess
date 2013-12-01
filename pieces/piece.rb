class Piece
  attr_reader :color, :board
  attr_accessor :unicode_char, :position

  def initialize(board, position, color)
    @board = board
    @position = position
    @color = color

    board.add_piece(@position, self)
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

