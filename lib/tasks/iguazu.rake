namespace :iguazu do
  desc "Run scrape jobs"
  task scrape: :environment do
    scrape_types = %w(golazo_argentino golazon hand_of_pod superliga_video)

    threads = scrape_types.shuffle.map do |type|
      Thread.new do
        puts "#{type}: start"
        result = ScrapeJob.perform_now(type)
        puts "#{type}: end (#{result.nil? ? 'not executed' : result.count.to_i})"
      end
    end

    threads.map(&:join)
  end
end
