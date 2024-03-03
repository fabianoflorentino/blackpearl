# frozen_string_literal: true

# AddIndexBalanceToCustomer class
class AddIndexBalanceToCustomer < ActiveRecord::Migration[7.1]
  def up
    add_index :customers, :balance
  end

  def down
    remove_index :customers, :balance
  end
end
