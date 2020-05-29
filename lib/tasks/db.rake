#sqlite3 development.sqlite3 .dump > development.dump.sql
namespace :db do

  desc "Creates db/<environment>.dump.sql and db/<timestamp>_<environment>.dump.sql file from <environment>.sqlite3"
  task :dump => :environment do
    path = "#{Rails.root}/db"
    file_name = "#{Rails.env}.dump.sql"
    dump_file = "#{path}/#{file_name}"
    system("sqlite3 #{path}/#{Rails.env}.sqlite3 .dump > #{dump_file}")
    system("cp #{dump_file} #{path}/#{DateTime.now.to_s(:number)}_#{file_name}")
  end

  desc "Compress db/*.dump.sql to db/*.dump.sql.bz2"
  namespace :dump do
    task :bzip2 => :environment do
      puts "Todo"
    end

    task :bunzip2 => :environment do
      puts "Todo"
    end
  end

  desc "Import a db/<environment>.dump.sql file into <environment>.sqlite3"
  task :import => :environment do
    dump_file = "#{Rails.root}/db/#{Rails.env}.dump.sql"
    if File.exists?(dump_file)
      system("sqlite3 #{Rails.root}/db/#{Rails.env}.sqlite3 < #{dump_file}")
    else
      puts "Dump file #{dump_file} does not exist."
    end
  end

end