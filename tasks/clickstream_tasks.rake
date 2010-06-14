# Generate the migrations specified in lib/db/migrations
namespace :db do
  namespace :migrate do
    description = "Migrate the database through scripts in vendor/plugins/clickstream/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."

    desc description
    task :clickstream => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate("vendor/plugins/clickstream/lib/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil)
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
    
  end
end

namespace :clicks do
  desc "Remove clicks that don't belong to a clickstream that is associated with a user."
  task :destroy_userless => :environment do
    clickstreams = ClickStream.all
    deleted = 0
    saved = 0
    for cs in clickstreams
      if cs.user.nil?
        cs.destroy
        deleted = deleted + 1
      else
        saved = saved + 1
      end
    end
    puts "Deleted " + deleted.to_s
    puts "Kept " + saved.to_s
  end
end