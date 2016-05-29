class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.decimal :open_price
      t.decimal :close_price

      t.timestamps
    end
  end
end
