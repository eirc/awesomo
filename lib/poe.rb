require "open-uri"
require "net/http"
require "nokogiri"
require "json"

class Poe
  class Account
    attr_accessor :name, :default_character

    def initialize(name)
      self.name = name
    end

    def last_active
      page = Nokogiri::HTML(open("https://www.pathofexile.com/account/view-profile/#{name}/characters"))
      script = page.css('script').find {|script| script.text.include? "PoE/Backbone/Model/Character/Character"}
      name = JSON.parse(script.text.scan(/new C\((.*)\)/).first.first)['name']
      Character.new self, name
    end
  end

  class Character
    attr_accessor :account, :name

    def initialize(account, name)
      self.account = account
      self.name = name
    end

    def items
      @items ||= begin
        http_response = Net::HTTP.post_form(URI.parse("https://www.pathofexile.com/character-window/get-items"), {accountName: account.name, character: name})
        json_response = JSON.parse http_response.body
        json_response["items"]
      end
    end

    def item_at(slot)
      items.find {|item| item["inventoryId"] == slot}
    end
  end
end

