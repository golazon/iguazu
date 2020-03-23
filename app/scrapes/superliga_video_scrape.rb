class SuperligaVideoScrape < ApplicationScrape
  CHANNEL_ID = 'UCJmCVoUfCBQb9lcfXIS8nXQ'.freeze
  URL = "https://www.youtube.com/feeds/videos.xml?channel_id=#{CHANNEL_ID}".freeze

  class << self
    def scrapes
      xml(URL) do |doc|
        doc.css('entry').map { |node| new(node) }.select(&:valid?)
      end
    end
  end

  def valid?
    return false unless node
    return false unless /Fecha \d{2}: resumen/.match?(org_title)

    true
  end

  def id
    node.at_css('id').text
  end

  def content
    { title: title, message: message, url: url, thumbnail_url: thumbnail_url, yt_video_id: yt_video_id }
  end

  def published_at
    Time.zone.parse(node.at_css('published').text)
  end

  private

  def title
    @title ||= org_title.gsub(/Fecha \d{2}: resumen de /, "").concat(' (highlights)')
  end

  def org_title
    @org_title ||= node.at_css('title').text
  end

  def message
    node
      .at_css('media|description')
      .text
      .squish
  end

  def url
    node.at_css('link')['href']
  end

  def thumbnail_url
    node.at_css('media|thumbnail')['url']
  end

  def yt_video_id
    node.at_css('yt|videoId').text
  end
end
