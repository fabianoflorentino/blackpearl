# frozen_string_literal: true

# Add Email and Password to Customers class
class AddEmailAndPasswordToCustomers < ActiveRecord::Migration[7.1]
  def change
    change_table :customers, bulk: true do |t|
      t.string :email
      t.string :password
    end
  end
end
