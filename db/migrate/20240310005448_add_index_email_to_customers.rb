# frozen_string_literal: true

# Add Index Email to Customers class
class AddIndexEmailToCustomers < ActiveRecord::Migration[7.1]
  def up
    add_index :customers, :email, unique: true
  end

  def down
    remove_index :customers, :email
  end
end
