class Board
attr_accessor :grid

  def initialize(grid = Board.default_grid)
      @grid = grid
  end

  def self.default_grid
    Array.new(10) { Array.new(10) }
  end

  def count
    count = 0
    @grid.each do |row|
      row.each do |column|
        if column == :s
          count += 1
        end
      end
    end
    count
  end

  def empty?(pos = nil)
    if pos
      x, y = pos
      return @grid[x][y].nil?
    else
      return @grid.all? {|row| row.all? {|el| el == nil}}
    end
  end

  def full?
    # @grid.each do |row|
    #   row.each do |el|
    #     if el != :s
    #       return false
    #     end
    #   end
    # end
    self.count == @grid.length * @grid.length
    # true
  end

  def []=(pos, mark)
    x, y = pos
    @grid[x][y] = mark
  end

  def [](pos)
    x,y = pos
    @grid[x][y]
  end

  def place_random_ship
    if self.full?
      raise "The board is full!!"
    else
      pos = [rand(@grid.length), rand(@grid.length)]
      if empty?(pos)
        @grid[pos[0]][pos[1]] = :s
      end
    end

  end

  def won?
    # @grid.each do |row|
    #   row.each do |el|
    #     if el == :s
    #       return false
    #     end
    #   end
    # end
    count == 0
    # true
  end

  def board
    @grid
  end

  def display
    print "_" * @grid.length * 7
    puts ""
    @grid.each do |row|
      row.each do |el|
        if el == :x
          print " | X | "
        elsif el == :s
          print " | S | "
        elsif el == "W"
          print " | w | "
        else
          print " |   | "
        end
      end
      print "\n"
    end
  end

end
