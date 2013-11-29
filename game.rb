require_relative 'board'

class Game
  attr_reader :board
  # Ned initializes players as a hash { :color => new Human }
  # and current player to color
  def initialize
    @board = Board.new
  end

  def play(player1, player2)
    current_player = player1

    until board.checkmate?(current_player.color)
      puts "#{current_player.color}'s Turn \n\n"
      # think about putting this begin, rescue to PLAY_TURN method
      begin
        board.display_grid # should display board in PLAY_TURN
        start_pos, end_pos = current_player.play_turn
        check_move_validity(start_pos, current_player)
        board.move(start_pos, end_pos)
      rescue NotYourPieceError => error
        puts error.message
        retry
      rescue MovePieceError => error
        puts error.message
        retry
      end

      current_player = current_player == player1 ? player2 : player1
    end
    puts "CHECKMATE! \n\n #{current_player.color} won!"
  end

  # these errors should be in the board class in the MOVES method
  def check_move_validity(start_pos, current_player)
    if board[start_pos].nil?
      raise MovePieceError.new("THERE IS NO PIECE TO MOVE")
    elsif board[start_pos].color != current_player.color
      raise NotYourPieceError.new("YOU CAN'T MOVE YOUR OPPONENT'S PIECE")
    end
  end
end

class HumanPlayer
  attr_reader :color

  def initialize(color)
    @color = color
  end
  # can create a GET_POS method for the user prompts
  def play_turn
    puts "Please choose a piece to move, enter in this format 'x,y'"
    start_pos = gets.chomp.split(",").map { |i| i.to_i }

    puts "Where would you like to move this piece, enter in this format 'x,y'"
    end_pos = gets.chomp.split(",").map { |i| i.to_i }

    [start_pos, end_pos]
  end

end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new

  player1 = HumanPlayer.new("white")
  player2 = HumanPlayer.new("black")
  new_game.play(player1, player2)

end