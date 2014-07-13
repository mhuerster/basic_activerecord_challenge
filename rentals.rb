require 'active_record'

require 'minitest/autorun'
require 'minitest/spec'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :users do |t|
  t.string :name
  t.string :credit_card
end

ActiveRecord::Migration.create_table :cars do |t|
  t.string :model
  t.string :color
  t.string :make
end

ActiveRecord::Migration.create_table :rental_cars do |t|
  t.references :user
  t.references :car
end


ActiveRecord::Migrator.up "db/migrate"

class User < ActiveRecord::Base
  has_many :rental_cars
  has_many :cars, through: :rental_cars 
end

class Car < ActiveRecord::Base
  has_many :rental_cars
  has_many :users, through: :users
end

class RentalCar < ActiveRecord::Base
  belongs_to :car
  belongs_to :user
end


# Seeding DB


