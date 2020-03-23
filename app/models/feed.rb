class Feed < ApplicationRecord
  self.inheritance_column = :_type_disabled

  validates :type, presence: true, uniqueness: { scope: :type_id }
  validates :type_id, presence: true
  validates :content, presence: true

  def self.create_from_scrape(scrape)
    return false if scrape.respond_to?(:valid?) && !scrape.valid?

    create_with(content: scrape.content, published_at: scrape.published_at)
      .find_or_create_by(type: scrape.type, type_id: scrape.id)
  end
end
