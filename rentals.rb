require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

# Define your migrations here, they should take the form of:
#
# ActiveRecord::Migration.create_table :fruits do |t|
#   t.string :name
#   t.belongs_to :bowl
# end
#
# Repeat the above template for each table you need to create

ActiveRecord::Migration.create_table :users do |t|
	t.string :name, :state
	t.integer :age
	t.string :state
	t.timestamps
end

ActiveRecord::Migration.create_table :cars do |t|
	t.string :make, :model, :license_plate, :state
	t.integer :year
	t.timestamps
end

ActiveRecord::Migration.create_table :rental_cars do |t|
	t.references :users
	t.references :car
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

	has_many :rental_cars
	has_many :cars, through: :rental_cars
	validates :age, numericality: {greater_than_or_equal_to: 25 }
end

class Car < ActiveRecord::Base
	has_many :rentals, class_name: "RentalCar"
	has_many :users, through: :rentals
end

class RentalCar < ActiveRecord::Base
	belongs_to :customer, class_name: "User"
	belongs_to :car
end



#
# end migrations
