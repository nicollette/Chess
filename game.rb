require './board'

class Game
  def initialize
    @board = Board.new
  end

  def play(player1, player2)
    current_player = player1
    until @board.checkmate?(current_player.color)

      puts "#{current_player.color}'s Turn"
      puts
      @board.display_grid
      begin
        starting_pos, ending_pos = current_player.play_turn
        check_move_validity(starting_pos, current_player)
        @board.move(starting_pos, ending_pos)
      rescue NotYourPieceError => error
        puts error.message
        retry
      rescue MovePieceError => error
        puts error.message
        retry
      end
      current_player = current_player == player1 ? player2 : player1
    end
    puts "#{current_player.color} won!"
  end

  def check_move_validity(starting_pos, current_player)
    start_obj = @board.grid[starting_pos[0]][starting_pos[1]]
    raise MovePieceError.new("No piece at starting position") if start_obj.nil?
    if @board.grid[starting_pos[0]][starting_pos[1]].color != current_player.color
      raise NotYourPieceError.new("You can't move the other player's piece.")
    end
  end

end

class NotYourPieceError < StandardError
end

class MovePieceError < StandardError
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def play_turn
    puts "Please choose a starting piece to move: x,y"
      starting_pos = gets.chomp.split(",").map { |i| i.to_i }

    puts "Where would you like to move the piece: x,y"
    ending_pos = gets.chomp.split(",").map { |i| i.to_i }

    [starting_pos, ending_pos]
  end

end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new


  player1 = HumanPlayer.new("white")
  player2 = HumanPlayer.new("black")
   new_game.play(player1, player2)

end