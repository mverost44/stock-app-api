class TradeSerializer < ActiveModel::Serializer
  attributes :id, :ticker_symbol, :entry_price, :exit_price, :entry_size, :exit_size, :total_profit_loss, :open
end
