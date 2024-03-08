# frozen_string_literal: true

# UpdateCustomerBalanceTrigger
class UpdateCustomerBalanceTrigger < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL.squish
      CREATE OR REPLACE FUNCTION update_customer_balance_trigger_function() RETURNS TRIGGER AS $$
      BEGIN
        PERFORM update_customer_balance(NEW.id);
        RETURN NEW;
      END;
      $$ LANGUAGE plpgsql;

      CREATE TRIGGER update_customer_balance_trigger
      AFTER INSERT ON transactions
      FOR EACH ROW
      EXECUTE FUNCTION update_customer_balance_trigger_function();
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP TRIGGER IF EXISTS update_customer_balance_trigger ON transactions;
      DROP FUNCTION IF EXISTS update_customer_balance_trigger_function();
    SQL
  end
end
