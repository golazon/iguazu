class HandOfPodScrape < ApplicationScrape
  URL = 'https://handofpod.wordpress.com/feed/'.freeze

  class << self
    def scrapes
      xml(URL) do |doc|
        doc.css('item').map { |node| new(node) }.select(&:valid?)
      end
    end
  end

  def valid?
    return false unless node

    true
  end

  def id
    node.at_css('guid').text
  end

  def content
    { title: title, message: message, url: url }
  end

  def published_at
    Time.zone.parse(node.at_css('pubDate').text)
  end

  private

  def title
    node.at_css('title').text
  end

  def message
    sanitize(node.at_css('content|encoded').text)
      .split("\n")
      .reject do |paragraph|
        ["Want to watch", "You can follow"].any? { |phrase| paragraph.starts_with? phrase }
      end
      .join
      .squish
  end

  def url
    node.at_css('link').text
  end
end
