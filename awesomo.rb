#!/usr/bin/env ruby

require 'discordrb'

bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN']

class DieRoll
  class BadSpec < RuntimeError
  end

  attr_accessor :rolls, :sides, :results, :comment

  def initialize(spec)
    match = spec.match /(?<rolls>\d+)?d(?<sides>\d+)/
    raise BadSpec.new unless match
    self.rolls = (match[:rolls] || 1).to_i
    self.sides = match[:sides].to_i
    self.results = rolls.times.collect {1 + rand(sides)}
  end

  def result
    @result ||= results.sum
  end

  def tier
    (result - bottom_roll).to_f / (top_roll - bottom_roll)
  end

  def top_roll
    @top_roll ||= rolls * sides
  end

  def bottom_roll
    @bottom_roll || rolls
  end

  def top_roll?
    result == top_roll
  end

  def bottom_roll?
    result == bottom_roll
  end
end

bot.mention contains: /roll .+/ do |event|
  begin
    roll = DieRoll.new event.text.match(/roll (?<spec>.+)/)[:spec]
    response = ":game_die: **#{roll.result}** :game_die:"
    if rand > 0.7
      comment = case
                when roll.top_roll?
                  "wow top roll!"
                when roll.bottom_roll?
                  "lol bottom roll :P"
                else
                  case roll.tier
                  when 0.0..0.2
                    "pretty shitty"
                  when 0.2..0.4
                    "below meh"
                  when 0.4..0.6
                    "meh"
                  when 0.6..0.8
                    "above average"
                  when 0.8..1.0
                    "peak performance!"
                  end
                end

      response << "\n_#{comment}_"
    end
    event.respond response
  rescue DieRoll::BadSpec
    event.respond "Dunno how to roll that... :confused:"
  end
end

bot.run
