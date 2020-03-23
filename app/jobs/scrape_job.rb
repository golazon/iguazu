class ScrapeJob < ApplicationJob
  def perform(scrape_type)
    scrape_class = scrape_class_for(scrape_type)
    return unless scrape_class.respond_to? :scrapes

    latest_scrape = latest_scrape_for(scrape_type)

    scrape_class.scrapes&.map do |scrape|
      break if latest_scrape && scrape.published_at < latest_scrape.published_at

      Feed.create_from_scrape(scrape)
    end
  end

  private

  def latest_scrape_for(scrape_type)
    Feed.order(published_at: :desc).find_by(type: scrape_type)
  end

  def scrape_class_for(scrape_type)
    scrape_class_name = scrape_type.to_s.classify
    scrape_class_name += 'Scrape' unless scrape_class_name.end_with?('Scrape')
    scrape_class_name.constantize
  end
end
