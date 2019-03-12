class CreateTrades < ActiveRecord::Migration[5.2]
  def change
    create_table :trades do |t|
      t.string :ticker_symbol
      t.decimal :entry_price, precision: 10, scale: 2
      t.decimal :exit_price, precision: 10, scale: 2
      t.integer :entry_size
      t.integer :exit_size
      t.datetime :entry_date
      t.datetime :exit_date
      t.boolean :open, default: true, null: false
      t.decimal :total_profit_loss, precision: 10, scale: 2

      t.timestamps
    end
  end
end
