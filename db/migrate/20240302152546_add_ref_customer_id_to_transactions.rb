# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class AddRefCustomerIdToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_reference :transactions, :customers, null: false, default: 1, foreign_key: true
  end

  def down
    remove_reference :transactions, :customers
  end
end
