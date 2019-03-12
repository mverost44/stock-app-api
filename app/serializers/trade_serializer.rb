class TradeSerializer < ActiveModel::Serializer
  attributes :id, :ticker_symbol, :entry_price, :exit_price, :entry_size, :exit_size, :entry_date, :exit_date, :total_profit_loss, :open
end
