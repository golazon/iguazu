require 'test_helper'

class GolazonScrapeTest < ActiveSupport::TestCase
  context ".scrapes" do
    setup do
      GolazonScrape::COMPETITION_URLS.each do |url|
        stub_request(:get, url)
          .to_return(body: file_fixture('golazon-competition.json'))
      end

      stub_request(:get, GolazonScrape::SEASON_URL_TEMPLATE.gsub('SEASON_ID', '3e7rz'))
          .to_return(body: file_fixture('golazon-matches.json'))

      stub_request(:get, GolazonScrape::MATCH_URL_TEMPLATE.gsub('MATCH_ID', 'lg9k5g'))
          .to_return(body: file_fixture('golazon-match.json'))

      Timecop.freeze(Time.zone.parse('2020-02-25 05:00:00')) do
        @scrapes = GolazonScrape.scrapes
      end
    end

    should "happy path" do
      assert_equal 1, @scrapes.count
    end
  end
end
