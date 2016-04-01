module PricingPolicy
  class Base
    @@cache = {}

    def total_for(base_price)
      raise NotImplementedError.new("Use a specific policy instead")
    end

    def scrape(url)
      fetch(url) { visible_text_from(url) }
    end

    private

    def fetch(key)
      return @@cache[key][0] if @@cache.has_key?(key) && @@cache[key][1] > 10.minutes.ago

      if block_given?
        content = yield
        @@cache[key] = [ content, Time.now ]
        content
      end
    end

    def visible_text_from(url)
      require 'nokogiri'
      require 'open-uri'

      doc = Nokogiri.HTML(open(url))
      %w{style script}.each { |tag| doc.css(tag).remove }
      doc.at('body').inner_text
    end
  end

  class Flexible < Base
    def total_for(base_price)
      base_price.to_i * scrape("http://reuters.com").count("a") / 100.0
    end
  end

  class Fixed < Base
    def total_for(base_price)
      base_price.to_i + scrape("https://developer.github.com/v3/#http-redirects").scan(/\w+/).count("status")
    end
  end

  class Prestige < Base
    def total_for(base_price)
      base_price.to_i + margin_for("http://www.yourlocalguardian.co.uk/sport/rugby/rss/")
    end

    def margin_for(url)
      require 'rss'

      rss = fetch(url) { RSS::Parser.parse(url) }
      margin = rss.items.select {|i| i.respond_to?(:pubDate)}.count
      margin += 1 if rss.channel.respond_to?(:pubDate)
      margin
    end
  end
end