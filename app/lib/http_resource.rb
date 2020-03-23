class HttpResource
  class << self
    def xml(url)
      get(url) do |response|
        doc = Nokogiri::XML(response.body)
        yield(doc)
      end
    end

    def json(url)
      get(url) do |response|
        doc = JSON.parse(response.body)
        yield(doc)
      end
    end

    private

    def get(url)
      log = HttpLog.find_or_initialize_by(url: url)

      return if log.expires.present? && log.expires > Time.zone.now

      response = Typhoeus.get(
        url,
        headers: {
          'User-Agent' => 'Iguazu (albicelestes.com)',
          'If-Modified-Since' => log.last_modified&.rfc822,
          'If-Match' => log.etag
        }.compact
      )

      return unless response.response_code == 200

      result = yield(response)

      if response.headers.present?
        log.etag = response.headers&.dig('etag')
        log.last_modified = response.headers&.dig('last-modified')

        if response.headers['expires'].present?
          log.expires = response.headers['expires']
        elsif response.headers['cache-control'].present?
          max_age = /max-age=(?<max_age>\d+)/.match(response.headers['cache-control']).try("max_age").to_i
          log.expires = max_age.seconds.from_now unless max_age.zero?
        end
      end

      log.save!

      result
    end
  end
end
