# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class AddRefCustomerIdToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_column :transactions, :customer_id, :uuid
    add_foreign_key :transactions, :customers, column: :customer_id, primary_key: :id
  end

  def down
    remove_foreign_key :transactions, :customers
    remove_column :transactions, :customer_id
  end
end
