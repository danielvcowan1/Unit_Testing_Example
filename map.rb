# frozen_string_literal: true

# map.rb
require_relative 'mines'

# This class contains the method for moving a prospector
class Map
  attr_reader :nodes

  def initialize
    @nodes = [Mines.new('Enumerable Canyon', 0, 1, 1, [1, 2]),
              Mines.new('Duck Type Beach', 1, 2, 2, [0, 4]),
              Mines.new('Monkey Patch City', 2, 1, 1, [0, 3, 4]),
              Mines.new('Nil Town', 3, 0, 3, [2, 5]),
              Mines.new('Matzburg', 4, 3, 0, [1, 2, 5, 6]),
              Mines.new('Hash Crossing', 5, 2, 2, [3, 4, 6]),
              Mines.new('Dynamic Palisades', 6, 2, 2, [4, 5])]
  end

  def ramble_on(rng, id)
    rand_pick = rng.rand(nodes[id].neighbors.length)
    id_next_stop = nodes[id].neighbors[rand_pick]
    nodes[id_next_stop]
  end
end
