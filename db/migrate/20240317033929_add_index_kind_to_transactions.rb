# frozen_string_literal: true

# AddIndexKindToTransactions
class AddIndexKindToTransactions < ActiveRecord::Migration[7.1]
  def up
    add_index :transactions, :kind
  end

  def down
    remove_index :transactions, :kind
  end
end
