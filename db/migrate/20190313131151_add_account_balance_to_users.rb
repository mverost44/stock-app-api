class AddAccountBalanceToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :account_balance, :decimal, precision: 10, scale: 2, default: 20000
  end
end
