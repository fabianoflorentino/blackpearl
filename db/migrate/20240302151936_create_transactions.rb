# frozen_string_literal: true

# Transaction model which is used to interact with the database.
class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions, id: :uuid do |t|
      t.integer :amount, null: false
      t.string :kind, null: false
      t.text :description, null: false, limit: 10

      t.timestamps
    end
  end
end
