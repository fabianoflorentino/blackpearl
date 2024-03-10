# frozen_string_literal: true

# Add an index to the name column in the customers table to improve the performance of the application.
class AddIndexNameToCustomers < ActiveRecord::Migration[7.1]
  def up
    add_index :customers, :name, unique: true
  end

  def down
    remove_index :customers, :name
  end
end
