require 'colorize'
require_relative 'pieces'
require_relative 'exceptions'

class Board
  attr_accessor :grid

  def initialize(fill_board)
    create_board(fill_board)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, piece)
    x, y = pos
    grid[x][y] = piece
  end

  def add_piece(pos, piece)
    self[pos] = piece
  end

  def checkmate?(color)
    return false unless in_check?(color)
    pieces.select { |piece| piece.color == color }.all? do |piece|
      piece.valid_moves.empty?
    end
  end

  def display_grid
    puts "   0 1 2 3 4 5 6 7 \n\n"

    grid.each_with_index do |row, row_idx|
      print "#{row_idx}  "
      row.each_with_index do |tile, col_idx|
        bg = background_color(row_idx, col_idx)

        if tile.nil?
          print "  ".colorize(:color => :red, :background => bg)
        else
          print "#{tile.render} ".colorize(:color => :red, :background => bg)
        end
      end
      puts "\n"
    end
  end

  def dup
    new_board = Board.new(false)

    pieces.each do |piece|
      piece.class.new(new_board, piece.position, piece.color)
    end

    new_board
  end

  def in_check?(color)
    king_position = find_king_pos(color)
    return true if possible_opposing_moves(color).include?(king_position)
  end

  def move(start_pos, end_pos, current_player)
    if self[start_pos].nil?
      raise MovePieceError.new("THERE IS NO PIECE TO MOVE")
    elsif self[start_pos].color != current_player
      raise MovePieceError.new("YOU CAN'T MOVE YOUR OPPONENT'S PIECE")
    elsif !self[start_pos].moves.include?(end_pos)
      raise MovePieceError.new("THAT PIECE DOESN'T MOVE LIKE THAT")
    elsif !self[start_pos].valid_moves.include?(end_pos)
      raise MovePieceError.new("CAN'T MOVE INTO CHECK")
    end

    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    self[end_pos] = self[start_pos]
    self[start_pos] = nil
    self[end_pos].position = end_pos
  end

  def within_bounds?(x, y)
    [x, y].all? { |coord| coord.between?(0, 7) }
  end

  private
  def background_color(row_idx, col_idx)
    if (col_idx.odd? && row_idx.odd?) || (col_idx.even? && row_idx.even?)
      :black
    else
      :white
    end
  end
  
  def create_board(fill_board)
    @grid = Array.new(8) { Array.new(8) }
    if fill_board
      [:black, :white].each do |color|
        set_up_pawns(color)
        set_up_others(color)
      end
    end
  end

  def find_king_pos(color)
    pieces.find { |piece| piece.is_a?(King) && piece.color == color }.position
  end

  def pieces
    grid.flatten.compact
  end

  def possible_opposing_moves(color)
    selected_array_pieces = pieces.select do |piece|
      piece.color != color
    end
    
    possible_moves = selected_array_pieces.inject([]) do |result, piece|
      result.concat(piece.moves)
    end
    possible_moves.uniq
  end

  def set_up_pawns(color)
    row = color == :black ? 1 : 6
    8.times { |col| Pawn.new(self, [row, col], color) }
  end

  def set_up_others(color)
    backrow_pieces =
      [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    row = color == :black ? 0 : 7

    backrow_pieces.each_with_index do |piece, col|
      piece.new(self, [row, col], color)
    end
  end
end
