require 'test_helper'

class SuperligaVideoScrapeTest < ActiveSupport::TestCase
  context ".scrapes" do
    setup do
      stub_request(:get, SuperligaVideoScrape::URL)
        .to_return(body: file_fixture('superliga_youtube_channel.xml'))

      @scrapes = SuperligaVideoScrape.scrapes
    end

    should "filter out unwanted scrapes" do
      assert_equal 12, @scrapes.count

      invalid_ids = ['yt:video:9qvISlpPHvk', 'yt:video:cjlMTP7YDFc', 'yt:video:2tDInSI66iI']
      assert_equal [], (@scrapes.map(&:id) & invalid_ids)
    end

    should "return type" do
      @scrapes.each do |scrape|
        assert_equal 'superliga_video', scrape.type
      end
    end

    should "scrape id" do
      ['yt:video:0RtFuxcWhJA', 'yt:video:t6i420WfmD0', 'yt:video:yFpXPD-CSHI'].each_with_index do |id, i|
        assert_equal id, @scrapes[i].id
      end
    end

    should "scrape content" do
      content = {
        title: 'Godoy Cruz - Huracán (highlights)',
        message: "¡Victoria del Tomba en el cierre de la fecha 19! Con goles de Santiago García y de Miguel Merentiel, Godoy Cruz venció 2-1 a Huracán (Juan Vieyra) en Mendoza. #Superliga, presentada por Quilmes Clásica",
        url: 'https://www.youtube.com/watch?v=0RtFuxcWhJA',
        thumbnail_url: 'https://i1.ytimg.com/vi/0RtFuxcWhJA/hqdefault.jpg',
        yt_video_id: '0RtFuxcWhJA',
      }

      assert_equal content, @scrapes.first.content
    end

    should "scrape publish date" do
      dates = [
        'Tue, 11 Feb 2020 02:45:59 UTC +00:00',
        'Tue, 11 Feb 2020 00:51:49 UTC +00:00',
        'Mon, 10 Feb 2020 03:25:51 UTC +00:00',
      ]

      dates.each_with_index do |date, i|
        assert_equal Time.zone.parse(date), @scrapes[i].published_at
      end
    end
  end
end
