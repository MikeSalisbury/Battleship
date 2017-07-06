require_relative "board.rb"
require_relative "battleship.rb"

class HumanPlayer
  attr_accessor :name

  def initialize(name = "Mike")
    @name = name
  end

  def display(board)
    @board = board
  end

  def get_play
  p "please provide a position to strike in form x,y"
  pos = gets.chomp
  pos = pos.split(",").map(&:to_i)
  end

end

class ComputerPlayer
attr_reader :board

  def display(board)
    @board = board
  end

  def get_play
    available_pos = []
    (0...board.grid.length).each do |y|
      (0...board.grid.length).each do |x|
        pos = [x, y]
        if board[pos].nil? || board[pos] == :s
          available_pos << pos
        end
      end
    end

    rand_attack = available_pos.sample
  end

end
