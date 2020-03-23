require 'test_helper'

class GolazoArgentinoScrapeTest < ActiveSupport::TestCase
  context ".scrapes" do
    setup do
      stub_request(:get, GolazoArgentinoScrape::URL)
        .to_return(body: file_fixture('golazo_argentino.xml'))

      @scrapes = GolazoArgentinoScrape.scrapes
    end

    should "happy path" do
      assert_equal 10, @scrapes.count

      content = {
        title: 'Team & Goal of the week: Superliga 2019/20 Round Twenty',
        message: "River Plate maintained their lead at the top of the table with a win over Banfield but will be pushed by Boca Juniors after Carlos Tevez inspired the Xeneizes to a 4-0 win away to Central Córdoba.",
        url: 'https://golazoargentino.com/2020/02/18/team-goal-of-the-week-superliga-2019-20-round-twenty/',
      }

      assert_equal content, @scrapes.first.content
    end
  end
end
