require "minitest/autorun"
require "./lib/dice.rb"

class TestDice < Minitest::Test
  def test_rolls_one_die
    results = Dice::Roller.new("1d6").roll
    assert_kind_of Array, results
    assert_equal 1, results.length
    results.each do |result|
      assert_operator 1, :<=, result
      assert_operator 6, :>=, result
    end
  end

  def test_rolls_multiple_dice
    results = Dice::Roller.new("1000d20").roll
    assert_kind_of Array, results
    assert_equal 1000, results.length
    results.each do |result|
      assert_operator 1, :<=, result
      assert_operator 20, :>=, result
    end
  end

  def test_one_die_default_spec
    roller = Dice::Roller.new "d6"
    assert_equal 1, roller.rolls
    assert_equal 6, roller.sides
  end

  def test_d20_default_spec
    roller = Dice::Roller.new "2"
    assert_equal 2, roller.rolls
    assert_equal 20, roller.sides
  end

  def test_1d20_default_spec
    roller = Dice::Roller.new ""
    assert_equal 1, roller.rolls
    assert_equal 20, roller.sides
  end

  def test_bad_spec
    assert_raises Dice::BadSpec do
      Dice::Roller.new "wtf"
    end
  end

  def test_tier_top_roll
    roller = Dice::Roller.new "2d20"
    assert_equal :top_roll, roller.tier(40)
  end

  def test_tier_bottom_roll
    roller = Dice::Roller.new "2d20"
    assert_equal :bottom_roll, roller.tier(2)
  end

  def test_tier_numeric
    roller = Dice::Roller.new "2d6"
    assert_equal 0.5, roller.tier(7)
  end
end
