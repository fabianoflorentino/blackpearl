# frozen_string_literal: true

# UpdateCustomerBalanceFunction
class UpdateCustomerBalanceFunction < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL.squish
      CREATE OR REPLACE FUNCTION update_customer_balance(transaction_id UUID) RETURNS VOID AS $$
      DECLARE
        transaction_amount INT;
        transaction_kind VARCHAR;
        transaction_customer_id UUID;
        customer_limit INT;
        customer_balance INT;
        new_balance INT;
      BEGIN
        SELECT amount, kind, customer_id
        INTO transaction_amount, transaction_kind, transaction_customer_id
        FROM transactions WHERE id = transaction_id;

        SELECT customers.limit, customers.balance INTO
        customer_limit, customer_balance FROM customers WHERE id = transaction_customer_id;

        IF transaction_kind = 'c' THEN
          new_balance := customer_balance + transaction_amount;

          IF new_balance <= customer_limit THEN
            UPDATE customers SET balance = new_balance WHERE id = transaction_customer_id;
            UPDATE transactions SET updated_at = NOW() WHERE id = transaction_id;
          ELSE
            RAISE EXCEPTION 'Customer limit reached';
          END IF;
        END IF;

        IF transaction_kind = 'd' THEN
          new_balance := customer_balance - transaction_amount;

          IF new_balance >= customer_limit * -1 THEN
            UPDATE customers SET balance = new_balance WHERE id = transaction_customer_id;
            UPDATE transactions SET updated_at = NOW() WHERE id = transaction_id;
          ELSE
            RAISE EXCEPTION 'Customer limit reached';
          END IF;
        END IF;
      END;
      $$ LANGUAGE plpgsql;
    SQL
  end

  def down
    execute <<-SQL.squish
      DROP FUNCTION IF EXISTS update_customer_balance(UUID);
    SQL
  end
end
