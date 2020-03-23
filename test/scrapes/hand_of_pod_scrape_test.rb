require 'test_helper'

class HandOfPodScrapeTest < ActiveSupport::TestCase
  context ".scrapes" do
    setup do
      stub_request(:get, HandOfPodScrape::URL)
        .to_return(body: file_fixture('hand_of_pod.xml'))

      @scrapes = HandOfPodScrape.scrapes
    end

    should "happy path" do
      assert_equal 10, @scrapes.count

      content = {
        title: 'Episode 370: A familiar duo in the top two places',
        message: "On this week’s Hand Of Pod, Sam, English Dan, Andrés and Tony look back on a weekend of action which saw River Plate maintain their three-point lead at the top of the table, while Boca Juniors took advantage of Argentinos Juniors’ slip-up to go second. The Primera Femenina restarts this coming weekend so we give you an update on that, and there’s lots more besides.",
        url: 'https://handofpod.wordpress.com/2020/02/07/episode-370-a-familiar-duo-in-the-top-two-places/',
      }

      assert_equal content, @scrapes.first.content
    end
  end
end
