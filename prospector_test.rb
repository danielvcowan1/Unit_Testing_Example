# frozen_string_literal: true

# prospector_test.rb

require 'minitest/autorun'
require_relative 'prospector'

class ProspectorTest < Minitest::Test
  # Test that a Prospector object is created
  def test_prospector_initialize
    refute_nil Prospector.new(1, 1)
  end

  # setup a prospector intance for ease of testing
  # @test_p will be used in many of the following tests
  def setup
    @test_p = Prospector.new(1, 1)
  end

  # Test add_to_count method correctly updates ruby count
  def test_add_to_count
    @test_p.rubies_found = 2
    @test_p.ruby_count = 3
    @test_p.add_to_count
    assert_equal @test_p.ruby_count, 5
  end

  # Test add_to_count method correctly updates fake ruby count
  def test_add_to_count
    @test_p.fake_rubies_found = 2
    @test_p.fake_ruby_count = 3
    @test_p.add_to_count
    assert_equal @test_p.fake_ruby_count, 5
  end

  # Test increment_turns adds 1 to @turn when called
  def test_increment_turns
    @test_p.turn = 1
    @test_p.increment_turns
    assert_equal @test_p.turn, 2
  end

  # Test tally_day adds 1 to @days when called
  def test_tally_day
    @test_p.days = 1
    @test_p.tally_day
    assert_equal @test_p.days, 2
  end

  # UNIT TESTS FOR METHOD move?
  # Equivalence classes:
  # no rubies or fake rubies found 					-> returns true
  # rubies found, no fake rubies found				-> returns false
  # no rubies found, fake rubies found 				-> returns false
  # negative amount of rubies found					-> returns true
  # nothing found -> will move
  def test_move
    @test_p.rubies_found = 0
    @test_p.fake_rubies_found = 0
    assert @test_p.move?
  end

  # ruby found -> will stay
  def test_no_move_ruby
    @test_p.rubies_found = 1
    @test_p.fake_rubies_found = 0
    refute @test_p.move?
  end

  # fake ruby found -> will stay
  def test_no_move_fruby
    @test_p.rubies_found = 0
    @test_p.fake_rubies_found = 1
    refute @test_p.move?
  end

  # EDGE CASE for move? method returns true
  def test_no_move_edge
    @test_p.rubies_found = -1
    @test_p.fake_rubies_found = 0
    assert @test_p.move?
  end

  # UNIT TESTS FOR METHOD plural?
  # Equivalence classes:
  # one ruby					-> returns 'ruby'
  # multiple rubies				-> returns 'rubies'
  # one fake ruby				-> returns 'fake ruby'
  # multiple fake rubies		-> returns 'fake rubies'
  # The following 4 tests ensure ruby_string and fake_ruby_string are set correctly
  # one ruby
  def test_plural_ruby
    @test_p.plural?(1, 3)
    assert_equal @test_p.ruby_string, 'ruby'
  end

  # multiple rubies
  def test_plural_rubies
    @test_p.plural?(7, 1)
    assert_equal @test_p.ruby_string, 'rubies'
  end

  # one fake ruby
  def test_plural_fake_ruby
    @test_p.plural?(4, 1)
    assert_equal @test_p.fake_ruby_string, 'fake ruby'
  end

  # multiple fake rubies
  def test_plural_fake_rubies
    @test_p.plural?(1, 0)
    assert_equal @test_p.fake_ruby_string, 'fake rubies'
  end

  # tests that find_rubies method returns a random number in range 0..max allowable rubies
  # STUBBING method used here to stub out rand method so we can predict the return value
  def test_find_rubies
  	mock_rng = Minitest::Mock.new("mock")
	def mock_rng.rand(r); 3; end;
	assert_equal @test_p.find_rubies(mock_rng, 100), 3
  end

  # tests that find_frubies method returns a random number in range 0..max allowable fake rubies
  # STUBBING method used here to stub out rand method so we can predict the return value
  def test_find_frubies
  	mock_rng = Minitest::Mock.new("mock")
	def mock_rng.rand(r); 7; end;
	assert_equal @test_p.find_frubies(mock_rng, 100), 7
  end

  # UNIT TESTS FOR METHOD display_day
  # Equivalence classes:
  # Found both rubies and fake rubies	-> 'Found rubies and fake rubies in..' message displayed
  # Found only rubies					-> 'Found rubies in..' message displayed
  # Found only fake rubies				-> 'Found fake rubies in..' message displayed
  # Nothing found		-> 'Found no rubies or fake rubies in..' message diplayed
  # Negatives found		-> 'Found no rubies or fake rubies in..' message diplayed
  # Tests for correct output when both rubies and fake rubies found
  def test_display_both
  	mine = "apalachicola"
  	@test_p.rubies_found = 3
  	@test_p.fake_rubies_found = 7
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_string = 'fake rubies'
  	assert_output (/\tFound 3 rubies and 7 fake rubies in apalachicola.\n/) {@test_p.display_day(mine)}
  end

  # Tests for correct output when only rubies are found
  def test_display_ruby
  	mine = "apalachicola"
  	@test_p.rubies_found = 3
  	@test_p.fake_rubies_found = 0
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_string = 'fake rubies'
  	assert_output (/\tFound 3 rubies in apalachicola.\n/) {@test_p.display_day(mine)}
  end

  # Tests for correct output when only fake rubies are found
  def test_display_fruby
  	mine = "apalachicola"
  	@test_p.rubies_found = 0
  	@test_p.fake_rubies_found = 7
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_string = 'fake rubies'
  	assert_output (/\tFound 7 fake rubies in apalachicola.\n/) {@test_p.display_day(mine)}
  end

  # Tests for correct output when nothing is found
  def test_display_none
  	mine = "apalachicola"
  	@test_p.rubies_found = 0
  	@test_p.fake_rubies_found = 0
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_string = 'fake rubies'
  	assert_output (/\tFound no rubies or fake rubies in apalachicola.\n/) {@test_p.display_day(mine)}
  end

  # Tests for correct output should negative rubies be found
  # EDGE CASE
  def test_display_neg
  	mine = "apalachicola"
  	@test_p.rubies_found = -9
  	@test_p.fake_rubies_found = -700
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_string = 'rubies'
  	assert_output (/\tFound no rubies or fake rubies in apalachicola.\n/) {@test_p.display_day(mine)}
  end

  # Tests that correct output is displayed when display_trip method is called
  def test_display_trip
  	@test_p.days = 99
  	@test_p.id = 0
  	@test_p.ruby_count = 123
  	@test_p.ruby_string = 'rubies'
  	@test_p.fake_ruby_count = 321
  	@test_p.fake_ruby_string = 'fake rubies'
  	assert_output (/After 99 days, Rubyist 0 found:\n\t123 rubies.\n\t321 fake rubies.\n/) {@test_p.display_trip}
  end

  # UNIT TESTS FOR METHOD going_home_how?
  # Equivalence classes:
  # Ruby count 10..INFINITY	-> 'Going home victorious!' message displayed
  # Ruby count 1..9			-> 'Going home sad.' message displayed
  # Ruby count = 0			-> 'Going home empty-handed.' message displayed
  # Ruby count negative		-> 'Going home empty-handed.' message diplayed
  # Tests lower bound of 'victorious' case
  def test_going_home_vic
    @test_p.ruby_count = 10
    assert_output (/Going home victorious!/) {@test_p.going_home_how?}
  end

  # Tests upper bound of 'sad' case
  def test_going_home_sad
    @test_p.ruby_count = 9
    assert_output (/Going home sad./) {@test_p.going_home_how?}
  end

  # Tests lower bound of 'sad' case
  def test_going_home_sadder
    @test_p.ruby_count = 1
    assert_output (/Going home sad./) {@test_p.going_home_how?}
  end

  # Tests 'empty-handed' case
  def test_going_home_sadest
    @test_p.ruby_count = 0
    assert_output (/Going home empty-handed./) {@test_p.going_home_how?}
  end

  # Tests 'empty-handed' case with negative number
  # EDGE CASE
  def test_going_home_sadderest
    @test_p.ruby_count = -100
    assert_output (/Going home empty-handed./) {@test_p.going_home_how?}
  end
end
