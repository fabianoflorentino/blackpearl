# frozen_string_literal: true

# AddColumnRoleToCustomer
class AddColumnRoleToCustomer < ActiveRecord::Migration[7.1]
  def up
    add_column :customers, :role, :string, null: false, default: 'customer', limit: 20
  end

  def down
    remove_column :customers, :role
  end
end
