class GolazonScrape < ApplicationScrape
  BASE_URL = 'https://gf0tywygmf.execute-api.eu-west-2.amazonaws.com/prod/hyena?func='.freeze
  COMPETITION_URLS = ["#{BASE_URL}competitions/97m"].freeze
  SEASON_URL_TEMPLATE = "#{BASE_URL}seasons/SEASON_ID/matches/past/5".freeze
  MATCH_URL_TEMPLATE = "#{BASE_URL}matches/MATCH_ID".freeze

  class << self
    def scrapes
      COMPETITION_URLS.map do |url|
        json(url) do |competition|
          season_id = competition['season']['season_id']
          season_url = SEASON_URL_TEMPLATE.gsub('SEASON_ID', season_id)

          start_date = Date.parse(competition['season']['start_date'])
          end_date = Date.parse(competition['season']['end_date'])
          today = Time.zone.today

          next [] if today < start_date || end_date < today

          json(season_url) do |fixtures|
            fixtures.map do |fixture|
              fixture_id = fixture['match_id']
              fixture_url = MATCH_URL_TEMPLATE.gsub('MATCH_ID', fixture_id)

              # prevent old games imported as current (published_at = now)
              kickoff = Time.zone.parse([fixture['date'], fixture['time']].join(' '))
              next if kickoff < 12.hours.ago

              next unless fixture['ended']
              next if Feed.where(type: 'golazon', type_id: fixture_id).any?

              json(fixture_url) { |match| new(match) }
            end
          end
        end
      end.flatten.compact
    end
  end

  def valid?
    return false unless node

    true
  end

  def id
    node['match_id']
  end

  def content
    {
      title: title,
      match: match,
    }
  end

  def published_at
    Time.zone.now
  end

  private

  def title
    "FT: #{node['home_name']} - #{node['away_name']} #{node['ft'].join(':')}"
  end

  def match
    node.slice(
      "competition_id",
      "competition_name",
      "home_name",
      "away_name",
      "ft",
      "home_players",
      "home_coach",
      "away_players",
      "away_coach",
      "goals",
      "cards",
      "venue",
    )
  end
end
