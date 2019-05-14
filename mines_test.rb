# frozen_string_literal: true

# mines_test.rb

require 'minitest/autorun'
require_relative 'mines'

class MinesTest < Minitest::Test
  # Test that a Mines bject is created
  def test_mines_initialize
    refute_nil Mines.new('test_mine', 7, 1, 1, [0, 1])
  end
end
