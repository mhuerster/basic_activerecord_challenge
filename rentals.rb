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
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.timestamps
    end
  end
end

class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :rate
      t.string :make
      t.string :model
      t.timestamps
    end
  end
end

class CreateRentalCars < ActiveRecord::Migration
  def change
    create_table :rental_cars do |t|
      t.references :user
      t.references :car
      t.timestamps
    end
  end
end
#
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
#
# You can define multiple classes, one after another

class User < ActiveRecord::Base
  has_many :rental_cars
  has_many :cars, :through => :rental_cars
end

class RentalCar < ActiveRecord::Base
  belongs_to :user
  belongs_to :car
end

class Car < ActiveRecord::Base
  has_many :rental_cars
  has_many :users, through: :rental_cars
end



#
# end migrations
