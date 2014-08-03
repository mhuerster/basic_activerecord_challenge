require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

# Define your migrations below:
# for example:
#
# ActiveRecord::Migration.create_table :fruits do |t|
#   t.string :name
#   t.belongs_to :bowl
# end
#
# Repeat the above template for each table you need to create

ActiveRecord::Migration.create_table :users do |user|
	user.string :name
	user.integer :age
	user.string :state
end

ActiveRecord::Migration.create_table :cars do |car|
	car.string :make
	car.string :model
	car.string :state
	car.string :license_plate
	car.date :year
	car.integer :rate
end

ActiveRecord::Migration.create_table :rental_cars do |rental|
	rental.belongs_to :user
end


# end migrations


# The following line executes the migrations. Don't delete it!
ActiveRecord::Migrator.up "db/migrate"

# Define your AR classes below:
# for example:
#
# class Fruit < ActiveRecord::Base
#   belongs_to :bowl
# end
#
# You can define multiple classes, one after another
class User < ActiveRecord::Base
	validates :age, numericality: {greater_than_or_equal_to: 25}
	has_many :rentals
	has_many :cars, through: :rental_cars, source: :cars
end

class Car < ActiveRecord::Base
	validates :license_plate, uniqueness: true
	has_many :rentals
	has_many :customers, through: :rental_cars, source: :user
end

class RentalCar <ActiveRecord::Base
	has_many :cars
	belongs_to :customer, class_name: "User", foreign_key: "user_id"
end

# end classes
