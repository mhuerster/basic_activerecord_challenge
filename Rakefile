require 'rake'
require_relative 'db/config'


desc "create the database"
task "db:create" do
  touch 'db/cars_and_rentals.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/cars_and_rentals.sqlite3'
end

desc "Migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
  task "db:migrate" do
    ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
    ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
    ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
      ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
    end
  end

# desc "populate the test database with sample data"
# task "db:populate" do
# end

desc "rollback your migration--use STEPS=number to step back multiple times"
task "db:rollback" do
  steps = (ENV['STEPS'] || 1).to_i
  ActiveRecord::Migrator.rollback('db/migrate', steps)
  Rake::Task['db:version'].invoke if Rake::Task['db:version']
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end