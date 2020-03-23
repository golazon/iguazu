class ApplicationScrape
  class << self
    delegate :xml, :json, to: HttpResource
  end

  def initialize(node)
    @node = node
  end

  def type
    self.class.name.demodulize.underscore.rpartition("_").first
  end

  private

  attr_reader :node

  # TODO: move as a concern?
  delegate :sanitize, to: :sanitizer
  def sanitizer
    @sanitizer ||= Rails::Html::FullSanitizer.new
  end
end
