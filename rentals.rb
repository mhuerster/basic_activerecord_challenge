require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Migration.create_table :users do |t|

  t.string :name
  t.string :state
  t.integer :age

  t.timestamps
end

ActiveRecord::Migration.create_table :cars do |t|

  t.string :make
  t.string :model
  t.string :state
  t.string :license_plate
  t.integer :year

  t.timestamps
end

ActiveRecord::Migration.create_table :rental_cars do |t|
  t.belongs_to :user

  t.timestamps
end

# Define your migrations below:
# for example:
#
# ActiveRecord::Migration.create_table :fruits do |t|
#   t.string :name
#   t.belongs_to :bowl
# end
#
# Repeat the above template for each table you need to create
#
# end migrations


# The following line executes the migrations. Don't delete it!
ActiveRecord::Migrator.up "db/migrate"

# Define your AR classes below:
# for example:
#
# class Fruit < ActiveRecord::Base
#   belongs_to :bowl
# end

class User < ActiveRecord::Base
  validates :age, numericality: { greater_than_or_equal_to: 25 }

  has_many :cars, through: :rental_cars
  has_many :rental_cars
end

class Car < ActiveRecord::Base
  validates :license_plate, uniqueness: true

  has_many :customers, through: :rental_cars, source: :user

  has_many :rental_cars
  has_many :rentals, class_name: "RentalCar"
end

class RentalCar < ActiveRecord::Base
  belongs_to :customer, class_name: "User"
  belongs_to :car

end

#
# You can define multiple classes, one after another

# end classes
