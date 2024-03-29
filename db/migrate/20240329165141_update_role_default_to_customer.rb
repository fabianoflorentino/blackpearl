# frozen_string_literal: true

# This migration is to update the default role of the user to customer
class UpdateRoleDefaultToCustomer < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL.squish
      UPDATE customers SET role = 'customer' WHERE role IS NULL;
    SQL
  end

  def down
    execute <<-SQL.squish
      UPDATE customers SET role = NULL WHERE role = 'customer' OR role = 'admin';
    SQL
  end
end
