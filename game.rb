require_relative 'board'

class Game
  attr_reader :board, :current_player, :players

  def initialize
    @board = Board.new(true)
    @players = {
      :white => HumanPlayer.new(:white),
      :black => HumanPlayer.new(:black)
    }
    @current_player = :white
  end

  def play
    until board.checkmate?(current_player)
      players[current_player].play_turn(board)
      @current_player = (current_player == :white) ? :black : :white
    end
    board.display
    puts "\nCHECKMATE! \n\n#{current_player.to_s} won!"
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn(board)
    board.display_grid
    puts "\n#{color.upcase}'s Turn \n\n"

    begin
      start_pos = get_position("Please choose a piece to move (format: x,y)")
      end_pos = get_position("To which position? (format x,y)")
      board.move(start_pos, end_pos, color)
    rescue MovePieceError => error
      puts error.message
      retry
    end
  end

  private
  def get_position(prompt)
    puts prompt
    gets.chomp.split(",").map { |coord| Integer(coord) }
  end
end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new

  new_game.play

end