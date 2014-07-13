class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :users do |u|
      u.string :name
      u.integer :age
      u.string :address
      u.timestamps
    end
  end
end