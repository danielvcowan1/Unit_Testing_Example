# frozen_string_literal: true

# arg_checker_test.rb

require 'minitest/autorun'
require_relative 'arg_checker'

class ArgCheckerTest < Minitest::Test
  # Test that a ArgChecker object is created
  def test_arg_checker_initialize
    refute_nil ArgChecker.new([1, 1, 1])
  end

  # setup for ease of subsequent tests
  # @args_array will be used frequently in the following tests
  def setup
    @args_array = ArgChecker.new([1, 1, 1])
  end

  # UNIT TESTS FOR METHOD check_arg_count
  # Equivalence classes:
  # command line input empty 				-> returns false
  # command line input 1..2					-> returns false
  # command line input length 4..INFINITY 	-> returns false
  # command line input length 3				-> returns true
  # This tests that check_arg_count returns true when length of input is 3
  def test_check_arg_count_pass
    assert @args_array.check_arg_count
  end

  # This tests that check_arg_count returns false when length of input is 0
  # EDGE CASE
  def test_check_arg_count_empty
    @args_empty = ArgChecker.new([])
    refute @args_empty.check_arg_count
  end

  # This tests that check_arg_count returns false when length of input is short
  def test_check_arg_count_short
    @args_short = ArgChecker.new([1, 1])
    refute @args_short.check_arg_count
  end

  # This tests that check_arg_count returns false when length of input is long
  def test_check_arg_count_long
    @args_long = ArgChecker.new([1, 1, 1, 1])
    refute @args_long.check_arg_count
  end

  # UNIT TESTS FOR METHOD check_arg_kind
  # Equivalence classes:
  # command line input is a string with no numbers in it 			-> returns false
  # command line input is a combination of numbers and characters 	-> returns false
  # command line input is any  positive integer						-> returns true
  # command line input is any  negative integer						-> returns true
  # tests string input
  def test_check_arg_kind_str
    @args_str = ArgChecker.new(['string'])
    refute @args_str.check_arg_kind(0)
  end

  # tests string and int input
  # EDGE CASE
  def test_check_arg_kind_strint
    @args_strint = ArgChecker.new(['3b'])
    refute @args_strint.check_arg_kind(0)
  end

  # tests positive int input
  def test_check_arg_kind_int
    @args_int = ArgChecker.new(['4'])
    assert @args_int.check_arg_kind(0)
  end

  # tests negative int input
  def test_check_arg_kind_negint
    @args_int = ArgChecker.new(['-1'])
    assert @args_int.check_arg_kind(0)
  end

  # UNIT TESTS FOR METHOD check_arg_value
  # Equivalence classes:
  # command line input is zero										-> returns true
  # command line input is any  positive integer						-> returns true
  # command line input is any  negative integer						-> returns false
  # tests zero input
  # EDGE CASE
  def test_check_arg_value_negzero
    @args_int = ArgChecker.new(['-0'])
    assert @args_int.check_arg_value(0)
  end

  # tests zero input
  def test_check_arg_value_zero
    @args_int = ArgChecker.new(['0'])
    assert @args_int.check_arg_value(0)
  end

  # tests positive input
  def test_check_arg_value_pass
    @args_int = ArgChecker.new(['1'])
    assert @args_int.check_arg_value(0)
  end

  # tests negative input
  def test_check_arg_value_fail
    @args_int = ArgChecker.new(['-1'])
    refute @args_int.check_arg_value(0)
  end
end
