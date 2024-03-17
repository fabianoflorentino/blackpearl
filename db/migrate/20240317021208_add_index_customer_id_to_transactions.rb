# frozen_string_literal: true

# AddIndexCustomerIdToTransactions
class AddIndexCustomerIdToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_index :transactions, :customer_id
  end

  def down
    remove_index :transactions, :customer_id
  end
end
