require_relative "board.rb"
require_relative "player.rb"

class BattleshipGame
  attr_reader :board, :player

  def initialize(player = ComputerPlayer.new, board = Board.new)
    @player = player
    @board = board

    2.times { @board.place_random_ship }

  end

  def attack(pos)
    if @board[pos] == :s
      @board[pos] = :x
      p "Direct hit!"
    else
      p "You hit open water"
      @board[pos] = "W"
    end
  end

  def count
    @board.count
  end

  def game_over?
    @board.won?
  end

  def play_turn
    pos = @player.get_play
    attack(pos)
  end

  def play
    p "Welcome to Battleship!"
    until self.game_over?
      @board.display
      @player.display(board)
      play_turn
    end
    p "you sunk my fleet!"
      @board.display

  end

end


if $0 == __FILE__
  game = BattleshipGame.new
  game.play
end
