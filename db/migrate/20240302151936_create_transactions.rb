# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.integer :amount, null: false, default: 0
      t.string :type, null: false
      t.text :desciption, null: false, limit: 10

      t.timestamps
    end
  end
end
