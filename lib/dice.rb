module Dice
  class BadSpec < RuntimeError
  end

  class Die
    attr_accessor :sides

    def initialize(sides)
      self.sides = sides
    end

    def roll
      rand(sides) + 1
    end
  end

  class Roller
    attr_accessor :rolls
    attr_accessor :sides

    def initialize(spec)
      match = spec.match /^(\d+)?(?:d(\d+))?$/
      raise BadSpec.new unless match
      self.rolls = (match[1] || 1).to_i
      self.sides = (match[2] || 20).to_i
    end

    def die
      @die ||= Die.new sides
    end

    def roll
      rolls.times.map {die.roll}
    end

    def top_roll
      rolls * sides
    end

    def bottom_roll
      rolls
    end

    def tier(sum)
      case sum
      when top_roll
        :top_roll
      when bottom_roll
        :bottom_roll
      else
        (sum - bottom_roll).to_f / (top_roll - bottom_roll)
      end
    end
  end
end
