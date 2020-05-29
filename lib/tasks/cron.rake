# run task from crontab
# cd YOUR_RAILS_APP_ROOT
# RAILS_ENV=production bundle exec rake cron:url:crawler

namespace :cron do
  namespace :url do

    desc "Run all cron:url tasks"
    task :all => :environment do
      Rake::Task['cron:url:crawler'].invoke()
      Rake::Task['cron:url:checker'].invoke()
      Rake::Task['cron:url:tweeter'].invoke()
    end

    desc "Checks, wether an url exists."
    task :checker => :environment do
      puts "checker job start"
      UrlChecker.run
      puts "checker job end"
    end

    desc "Crawls an url."
    task :crawler => :environment do
      puts "crawler job start"
      UrlCrawler.run
      puts "crawler job end"
    end

    desc "Tweets an url."
    task :tweeter => :environment do
      puts "tweeter job start"
      UrlTweeter.run
      puts "tweeter job end"
    end

  end
end
