class CreateCarRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |r|
      r.references :user
      r.references :car
      r.timestamps
    end
  end
end