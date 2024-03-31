# frozen_string_literal: true

# This migration is used to create a supervisor user with admin role.
class AddSupervisorUserToCustomers < ActiveRecord::Migration[7.1]
  SUPERVISOR_PASSWORD = SecureRandom.hex(16)
  private_constant :SUPERVISOR_PASSWORD

  def up
    execute <<-SQL.squish
      INSERT INTO customers (name, email, password, role, created_at, updated_at)
      VALUES ('Supervisor', 'supervisor@local.com', crypt('#{SUPERVISOR_PASSWORD}', gen_salt('bf')), 'admin', now(), now())
    SQL
  end

  def down
    execute <<-SQL.squish
      DELETE FROM customers WHERE email = 'supervisor@local.com' AND name = 'Supervisor'
    SQL
  end
end
