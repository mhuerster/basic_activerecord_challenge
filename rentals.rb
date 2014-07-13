require 'active_record'

require 'minitest/autorun'
require 'minitest/spec'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

#
# Define your migrations here, they should take the form of:
#
# ActiveRecord::Migration.create_table :fruits do |t|
#   t.string :name
#   t.belongs_to :bowl
# end
#
# Repeat the above template for each table you need to create

ActiveRecord::Migration.create_table :users do |u|
  u.string :name
  u.integer :age
  u.string :address
  u.timestamps
end

ActiveRecord::Migration.create_table :cars do |c|
  c.string :make
  c.string :model
  c.integer :year
  c.string :color
  c.timestamps
end

ActiveRecord::Migration.create_table :rentals do |r|
  r.references :user
  r.references :car
  r.timestamps
end

# end migrations
#
#
# the following line executes the migrations, don't delete it
ActiveRecord::Migrator.up "db/migrate"


#
# Define your AR classes below:
# for example:
#
# class Fruit < ActiveRecord::Base
#   belongs_to :bowl
# end

class User < ActiveRecord::Base
  has_many :rentals
  has_many :cars, through: :rentals
end

class Car < ActiveRecord::Base
  has_many :rentals
  has_many :users, through: :rentals
end

class Rental < ActiveRecord::Base
  has_many :users
  has_many :cars
end
#
# You can define multiple classes, one after another
