class Board
SHIPS = {
  Aircraft_Carrier: 5,
  Battleship: 4,
  Submarine: 3,
  Destroyer: 3,
  Patrol_Boat: 2
}

attr_accessor :grid

def initialize(grid = Board.default_grid)
    @grid = grid
    @initial_pos = []
end

def setup(ship_count = 5)
  ship_count.times {place_random_ship}
  @initial_pos.each do |pos|
    until extend_ship(pos)
    end
  end
end

def place_random_ship
  if self.full?
    raise "The board is full!!"
  else
    pos = [rand(@grid.length), rand(@grid.length)]
    if empty?(pos)

      @grid[pos[0]][pos[1]] = :s
      @initial_pos << pos
    end
  end

end

# selects random ship to build from SHIPS, returns the size of the ship
  def random_ship
    SHIPS[SHIPS.keys.sample]
  end

# extends ship from a given position in a random or given direction
  def extend_ship(pos, direction = ship_direction, size = nil)
    # this should be an option hash for direction and size
    possible_ship = []
    x, y = pos

    if size.nil?
      size = random_ship
    end

    if direction == "N" && (x - size - 1) >= 0
      (size-1).times do
        x -= 1
        possible_ship << [x, y]
      end

    elsif direction == "S" && (x + size - 1) <= @grid.length-1
      (size-1).times do
        x += 1
        possible_ship << [x, y]
      end

    elsif direction == "W" && (y - size - 1) >= 0
      (size-1).times do
        y -= 1
        possible_ship << [x, y]
      end

    elsif direction == "E" && (y + size - 1) <= @grid.length-1
      (size-1).times do
        y += 1
        possible_ship << [x, y]
      end
    end

    if possible_ship.all? {|pos| self[pos].nil?} && possible_ship.length >= 1
      possible_ship.each {|pos| self[pos] = :s}
      return true
    else
      return false
    end
  end

  def ship_direction
    ["N", "S", "W", "E"].sample
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
    x, y = pos
    @grid[x][y]
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
