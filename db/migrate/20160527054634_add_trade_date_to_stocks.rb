class AddTradeDateToStocks < ActiveRecord::Migration[5.0]
  def change
  	add_column :stocks, :trade_date, :date
  end
end
