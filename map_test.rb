# frozen_string_literal: true

# map_test

require 'minitest/autorun'
require_relative 'map'

class MapTest < Minitest::Test
  # Test that a Map object is created
  def test_map_initialize
    refute_nil Mines.new('test_mine', 0, 1, 1, [0, 1])
  end

  # This tests that ramble_on returns a neighboring mine
  # STUBBING used here to stub out the rand method so it always returns 2
  def test_ramble_on
  	test_map = Map.new
    mock_rng = Minitest::Mock.new("mock")
	def mock_rng.rand(r); 2; end;
	assert_equal test_map.ramble_on(mock_rng, 4), test_map.nodes[5]
  end

  # This tests that ramble_on returns a neighboring mine
  # STUBBING used here to stub out the rand method so it always returns 1
  def test_ramble_off
  	test_map = Map.new
    mock_rng = Minitest::Mock.new("mock")
	def mock_rng.rand(r); 1; end;
	refute_equal test_map.ramble_on(mock_rng, 0), test_map.nodes[3]
  end
end
