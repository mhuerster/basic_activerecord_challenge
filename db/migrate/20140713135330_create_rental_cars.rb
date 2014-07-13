class CreateRentalCars < ActiveRecord::Migration
  def change
    create_table :cars do |c|
      c.string :make
      c.string :model
      c.integer :year
      c.string :color
      c.timestamps
    end
  end
end