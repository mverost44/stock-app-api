class AddUserToTrades < ActiveRecord::Migration[5.2]
  def change
    add_reference :trades, :user, foreign_key: true
  end
end
