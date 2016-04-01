require 'rails_helper'
require 'pricing_policy'
require 'timecop'

RSpec.describe PricingPolicy do
  before do
    @text = "status mock data page content without an actual status"
    @content = "<body>#{@text}</body>"
    PricingPolicy::Flexible.class_variable_set :@@cache, {}
  end

  describe "caching" do
    subject { PricingPolicy::Flexible.new }

    it "caches the fetched content" do
      expect(subject).to receive(:open).once.and_return(@content)
      2.times { expect(subject.scrape("key")).to eq(@text) }
    end

    it "updates the cache on expiration" do
      expect(subject).to receive(:open).twice.and_return(@content)
      2.times do
        expect(subject.scrape("key")).to eq(@text)
        Timecop.travel(11.minutes.from_now)
      end
    end
  end

  describe "pricing" do
    before do
      @base_price = 200
    end

    describe "flexible" do
      subject { PricingPolicy::Flexible.new }

      it "calculation rule" do
        expect(subject).to receive(:open).and_return("<body>#{@text}</body>")
        expect(subject.total_for(@base_price)).to eq(@base_price * @text.count("a") / 100.0)
      end
    end

    describe "fixed" do
      subject { PricingPolicy::Fixed.new }

      it "calculation rule" do
        expect(subject).to receive(:open).and_return("<body>#{@text}</body>")
        expect(subject.total_for(@base_price)).to eq(@base_price + @text.scan(/\w+/).count("status"))
      end
    end

    describe "prestige" do
      subject { PricingPolicy::Prestige.new }

      it "calculation rule" do
        margin = 20

        expect(subject).to receive(:margin_for).and_return(margin)
        expect(subject.total_for(@base_price)).to eq(@base_price + margin)
      end
    end
  end
end
