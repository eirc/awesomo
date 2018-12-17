require "minitest/autorun"
require "./lib/poe.rb"

class TestPoe < Minitest::Test
  def test_gets_last_active
    account = Poe::Account.new "Pohx"
    character = account.last_active
    assert_equal "Pohx", character.account.name
    assert_equal "ReadyForRaidLeague", character.name
  end

  def test_gets_account_items
    account = Poe::Account.new "eirc"
    character = Poe::Character.new account, "WantToRenameCharacters"
    assert_equal "Bino's Kitchen Knife", character.item_at("Weapon")["name"]
  end

  def test_gets_account_items
    account = Poe::Account.new "eirc"
    character = Poe::Character.new account, "WantToRenameCharacters"
    p character.item_at("Weapon")
  end
end
