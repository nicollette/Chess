require 'colorize'
require_relative 'pieces'
require_relative 'exceptions'

class Board

  attr_accessor :grid
  # CREATE A VAR LIKE FILL_BOARD, TO DETERMINE WHETHER CREATING BOARD FOR DUP OR BLANK BOARD
  # CREATE ONE METHOD THAT TAKE FILL_BOARD VAR TO CREATE GRID, like MAKE_STARTING_GRID
  # create []= method

  def initialize(grid = nil)
    if grid.nil?
      @grid = Array.new(8) {Array.new(8)}
      set_up_pawns
      set_up_others
    else
      @grid = grid
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)
    # can compact this and chain the method calls!! don't need this local var
    our_pieces = pieces.select { |piece| piece.color == color }
    our_pieces.all? do |piece|
      piece.valid_moves.empty?
    end
  end
  # Ned's valid_pos? is cleaner:
    # def valid_pos?(pos)
   #      pos.all? { |coord| coord.between?(0, 7) }
   #    end
  def within_bounds?(x, y)
    [x, y].min >= 0 && [x, y].max < 8
  end

  def display_grid
    puts "   0 1 2 3 4 5 6 7"
    puts
    grid.each_with_index do |row, index|
      print "#{index}  "
      row.each_with_index do |tile, idx|
        bg_color = (idx.odd? && index.odd?) || (idx.even? && index.even?) ? :black : :white
        if tile.nil?
          print "  ".colorize(:color => :blue, :background => bg_color)
        else
          print "#{tile.render} ".colorize(:color => :blue, :background => bg_color)
        end
      end
      puts
    end
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  #need to move the check for valid starting pos from Game class to here
  # create seperate error for doing a move that will put you in check
  def move(start_pos, end_pos)
    unless self[start_pos].valid_moves.include?(end_pos)
      raise MovePieceError.new("Invalid ending position") #change this error to
                                                   #something more specific
    end

    move!(start_pos, end_pos)
  end

  def move!(start_pos, end_pos)
    a, b = start_pos
    x, y = end_pos

    grid[x][y] = grid[a][b]
    grid[a][b] = nil
    grid[x][y].position = end_pos
  end

  def in_check?(color)
    king_position = find_king_pos(color)
    return true if possible_opposing_moves(color).include?(king_position)
  end

  #if I change the Piece class to initialize and set itself on the board
  # then this can be much shorter, all I would need to do is call PIECES method
  # then generate new piece
  def dup
    duped_board = Board.new
    duped_array = Array.new(8) { Array.new(8) }
    duped_array.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        next if grid[row_idx][col_idx].nil?
        clr = grid[row_idx][col_idx].color
        piece = grid[row_idx][col_idx].class
        duped_piece = piece.new(duped_board, [row_idx, col_idx], clr)
        duped_array[row_idx][col_idx] = duped_piece
      end
    end
    duped_board.grid = duped_array
    duped_board
  end

  private

  # FIND method on return from PIECES method, instead of two loops~~~~
  def find_king_pos(color)
    grid.each do |row|
      row.each do |tile|
        return tile.position if (tile.is_a?(King) && tile.color == color)
      end
    end
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

  # CREATE ONE METHOD THAT TAKE FILL_BOARD VAR TO CREATE GRID, like MAKE_STARTING_GRID
       # pass color to helper set up pieces methods
       #change SET_UP_OTHERS to SET_UP_BACKROW
   # Ned has an ADD_PIECE method that assigns a piece to a pos on the board,
     # this is called from each initialization of the piece
     # and in the SET_UP methods, they ONLY create a new piece
     # and also means that don't have to have 2 loops to go through the board,
     # just pass row_idx, col_idx to pos in initialization of Piece
  def set_up_pawns
    [1, 6].each do |row|
      color = row == 1 ? "black" : "white"
      grid[row].each_index do |col|
        grid[row][col] = Pawn.new(self, [row, col], color)
      end
    end
  end
  # make BACKROW_PICES A LOCAL VAR IN SET_UP_OTHERS METHOD
  BACKROW_PIECES =
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]

  def set_up_others
    [0, 7].each do |row|
      color = row == 0 ? "black" : "white"
      BACKROW_PIECES.each_with_index do |piece, col|
        grid[row][col] = piece.new(self, [row, col], color)
      end
    end
  end
end
