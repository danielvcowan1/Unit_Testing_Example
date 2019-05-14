# frozen_string_literal: true

# File: ruby_rush.rb
# Name: Daniel Cowan
# Date: 3/2/2019
# Course: CS1632
# Project: D2

require_relative 'main'

args = ArgChecker.new(ARGV)

valid_count = args.check_arg_count

valid_kind = true
i = 0
while valid_kind
  break if i == ARGV.length

  valid_kind = args.check_arg_kind(i)
  i += 1
end

valid_value = true
i = 1
while valid_value
  break if i == ARGV.length

  valid_value = args.check_arg_value(i)
  i += 1
end

unless valid_count && valid_kind && valid_value
  puts "Usage:
ruby ruby_rush.rb *seed* *num_prospectors* *num_turns*
*seed* should be an integer
*num_prospectors* should be a non-negative integer
*num_turns* should be a non-negative integer"
  exit 1
end

valid_count && valid_kind && valid_value
seed = ARGV[0].to_i
num_prospectors = ARGV[1].to_i
num_turns = ARGV[2].to_i
map = Map.new
rng = Random.new seed
pros_array = (1..num_prospectors).to_a
pros_array.each do |j|
  mine = map.nodes[0]
  rubyist = Prospector.new(j, num_turns)
  puts format(
    'Rubyist %<id>d starting in %<m_name>s.',
    id: rubyist.id,
    m_name: mine.mine_name
  )
  until rubyist.turn == rubyist.num_turns
    move = false
    until move
      rubyist.rubies_found = rubyist.find_rubies(rng, mine.max_rubies)
      rubyist.fake_rubies_found = rubyist.find_frubies(rng, mine.max_fake_rubies)
      rubyist.add_to_count
      rubyist.plural?(rubyist.rubies_found, rubyist.fake_rubies_found)
      rubyist.display_day(mine.mine_name)
      rubyist.tally_day
      move = rubyist.move?
    end
    rubyist.increment_turns
    old_town = mine.mine_name
    mine = map.ramble_on(rng, mine.id)
    rubyist.check_turns(old_town, mine.mine_name)
  end
  rubyist.plural?(rubyist.ruby_count, rubyist.fake_ruby_count)
  rubyist.display_trip
  rubyist.going_home_how?
end
exit 0
