#!/usr/bin/env ruby

require 'discordrb'
require "./lib/dice.rb"

bot = Discordrb::Bot.new token: ENV['DISCORD_TOKEN']

bot.mention contains: /roll .+/ do |event|
  roll_spec = event.text.match(/roll (?<spec>.+)/)[:spec]

  begin
    roller = Dice::Roller.new roll_spec
  rescue Dice::BadSpec
    event.respond "Dunno how to roll that... :confused:"
    return
  end

  if roller.rolls > 100
    event.respond "I will not roll that many dice! :no_entry:"
    return
  end

  results = roller.roll

  response = ":game_die: **#{results.sum}** :game_die:"
  response << " (#{results.join(', ')})" if roller.rolls >= 2
  if rand > 0.7
    comment = case roller.tier results.sum
              when :top_roll
                "wow top roll!"
              when :bottom_roll
                "lol bottom roll :P"
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

    response << "\n_#{comment}_"
  end
  event.respond response
end

bot.run
