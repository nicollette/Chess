# encoding: utf-8
require './pawn.rb'
require './steppingpieces.rb'
require './slidingpieces.rb'
require 'colorize'

class Board

  attr_accessor :grid

  def initialize(grid = nil)
    if grid.nil?
      @grid = Array.new(8) {Array.new(8)}
      set_up_pawns
      set_up_others
    else
      @grid = grid
    end
  end

  def set_up_pawns
    [1, 6].each do |row|
      color = row == 1 ? "black" : "white"
      @grid[row].each_index do |col|
        @grid[row][col] = Pawn.new(self, [row, col], color)
      end
    end
  end

  BACKROW_PIECES = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
  def set_up_others
    [0, 7].each do |row|
      color = row == 0 ? "black" : "white"
      BACKROW_PIECES.each_with_index do |piece, col|
        @grid[row][col] = piece.new(self, [row, col], color)
      end
    end
  end

  def move(start_pos, end_pos)
    start_obj = @grid[start_pos[0]][start_pos[1]]

    raise MovePieceError.new("Invalid ending position") unless start_obj.valid_moves.include?(end_pos)

    move!(start_pos, end_pos)

  end

  def move!(start_pos, end_pos)
    start_obj = @grid[start_pos[0]][start_pos[1]]
    end_obj = @grid[end_pos[0]][end_pos[1]]
    @grid[end_pos[0]][end_pos[1]] = @grid[start_pos[0]][start_pos[1]]
    @grid[start_pos[0]][start_pos[1]] = nil
    @grid[end_pos[0]][end_pos[1]].position = end_pos
  end

  def within_bounds?(x, y)
    [x, y].min >= 0 && [x, y].max < 8
  end

  def display_grid
    puts "   0 1 2 3 4 5 6 7"
    puts
    @grid.each_with_index do |row, index|
      print "#{index}  "
      row.each_with_index do |tile, idx|
        bg_color = (idx.odd? && index.odd?) || (idx.even? && index.even?) ? :black : :white
        if tile.nil?
          print "  ".colorize(:color => :blue, :background => bg_color)
        else
          print "#{tile.render_unicode} ".colorize(:color => :blue, :background => bg_color)
        end
      end

      puts
    end
  end

  def in_check?(color)
    king_position = find_king_pos(color)
    return true if possible_opposing_moves(color).include?(king_position)
  end

  def checkmate?(color)
    return false unless in_check?(color)

    our_pieces = pieces.select { |piece| piece.color == color }
    our_pieces.all? do |piece|
      piece.valid_moves.empty?
    end

  end

  def find_king_pos(color)
    @grid.each do |row|
      row.each do |tile|
        return tile.position if (tile.is_a?(King) && tile.color == color)
      end
    end
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

  def pieces
    @grid.flatten.compact
  end

  def dup
    duped_board = Board.new
    dupped_array = Array.new(8) { Array.new(8) }
    dupped_array.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        next if @grid[row_idx][col_idx].nil?
        color = @grid[row_idx][col_idx].color
        duped_piece = @grid[row_idx][col_idx].class.new(duped_board, [row_idx, col_idx], color)
        dupped_array[row_idx][col_idx] = duped_piece
      end
    end
    duped_board.grid = dupped_array
    duped_board
  end

end

class MovePieceError < StandardError
end