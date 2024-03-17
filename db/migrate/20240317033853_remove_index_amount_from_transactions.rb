# frozen_string_literal: true

# RemoveIndexAmountFromTransactions
class RemoveIndexAmountFromTransactions < ActiveRecord::Migration[7.1]
  def up
    remove_index :transactions, :amount
  end
end
