# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class AddRefCustomerIdToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_reference :transactions, :customer, null: false, foreign_key: true
  end

  def down
    remove_reference :transactions, :customer
  end
end
