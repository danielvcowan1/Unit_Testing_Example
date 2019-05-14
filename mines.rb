# frozen_string_literal: true

# mines.rb
# This class holds all the attributes that a mine would have
class Mines
  attr_reader :mine_name, :id, :max_rubies, :max_fake_rubies, :neighbors

  def initialize(mine_name, id, max_rubies, max_fake_rubies, neighbors)
    @mine_name = mine_name
    @id = id
    @max_rubies = max_rubies
    @max_fake_rubies = max_fake_rubies
    @neighbors = neighbors
  end
end
