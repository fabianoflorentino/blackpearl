# frozen_string_literal: true

# CreateCustomers class
# This class is responsible for creating the customers table
# This table will store the customers' name, limit and balance
# This table will be used to store the customers' data
class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.integer :limit, default: 0
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end
