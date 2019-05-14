# frozen_string_literal: true

# arg_checker.rb

class ArgChecker
  def initialize(args)
    @args = args
  end

  def check_arg_count
    @args.length == 3
  end

  def check_arg_kind(i)
    @args[i] == @args[i].to_i.to_s
  end

  def check_arg_value(i)
    @args[i].to_i >= 0
  end
end
