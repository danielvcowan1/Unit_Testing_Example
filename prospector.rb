# frozen_string_literal: true

# Daniel Cowan
require_relative 'mines'
require_relative 'map'

# This class does prospector things
class Prospector
  attr_accessor :id, :num_turns, :turn, :ruby_count, :fake_ruby_count
  attr_accessor :rubies_found, :fake_rubies_found, :days, :ruby_string, :fake_ruby_string

  def initialize(id, num_turns)
    @id = id
    @num_turns = num_turns
    @turn = 0
    @ruby_count = 0
    @fake_ruby_count = 0
    @rubies_found = 0
    @fake_rubies_found = 0
    @days = 0
    @ruby_string = ''
    @fake_ruby_string = ''
  end

  def find_rubies(rng, max_rub)
    @rubies_found = rng.rand(max_rub + 1)
    @rubies_found
  end

  def find_frubies(rng, max_frub)
    @fake_rubies_found = rng.rand(max_frub + 1)
    @fake_rubies_found
  end

  def add_to_count
    @ruby_count += @rubies_found
    @fake_ruby_count += @fake_rubies_found
  end

  def increment_turns
    @turn += 1
  end

  def move?
    found_today = @rubies_found + @fake_rubies_found
    true if found_today <= 0
  end

  def plural?(ruby, fruby)
    @ruby_string = if ruby == 1
                     'ruby'
                   else
                     'rubies'
                   end

    @fake_ruby_string = if fruby == 1
                          'fake ruby'
                        else
                          'fake rubies'
                        end
  end

  def display_day(mine_name)
    if @rubies_found.positive? && @fake_rubies_found.positive?
      puts format(
        "\tFound %<rub_fnd>d %<rub_str>s and %<frub_fnd>d %<frub_str>s in %<m_name>s.",
        rub_fnd: @rubies_found,
        rub_str: @ruby_string,
        frub_fnd: @fake_rubies_found,
        frub_str: @fake_ruby_string,
        m_name: mine_name
      )
    elsif @rubies_found.positive?
      puts format(
        "\tFound %<rub_fnd>d %<rub_str>s in %<m_name>s.",
        rub_fnd: @rubies_found,
        rub_str: @ruby_string,
        m_name: mine_name
      )
    elsif @fake_rubies_found.positive?
      puts format(
        "\tFound %<frub_fnd>d %<frub_str>s in %<m_name>s.",
        frub_fnd: @fake_rubies_found,
        frub_str: @fake_ruby_string,
        m_name: mine_name
      )
    else
      puts format(
        "\tFound no rubies or fake rubies in %<m_name>s.",
        m_name: mine_name
      )
    end
  end

  def tally_day
    @days += 1
  end

  def display_trip
    puts format(
      'After %<day>d days, Rubyist %<ident>d found:',
      day: @days,
      ident: @id
    )
    puts format(
      "\t%<rub_cnt>d %<rub_str>s.",
      rub_cnt: @ruby_count,
      rub_str: @ruby_string
    )
    puts format(
      "\t%<frub_cnt>d %<frub_str>s.",
      frub_cnt: @fake_ruby_count,
      frub_str: @fake_ruby_string
    )
  end

  def check_turns(old_town, mine_name)
    if @turn == @num_turns
      false
    else
      puts 'Heading from ' + old_town + ' to ' + mine_name + '.'
      true
    end
  end

  def going_home_how?
    if @ruby_count >= 10
      puts 'Going home victorious!'
    elsif @ruby_count >= 1 && @ruby_count <= 9
      puts 'Going home sad.'
    else
      puts 'Going home empty-handed.'
    end
  end
end
