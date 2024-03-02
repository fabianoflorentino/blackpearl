# frozen_string_literal: true

# Added index to the amount column in the transactions table
class AddIndexAmountToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_index :transactions, :amount
  end

  def down
    remove_index :transactions, :amount
  end
end
