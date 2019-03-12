class CalculationsController < ProtectedController
  # Calculate total_profit_loss
  def profit_loss(entry_price, exit_price, entry_size)
    total_cost = entry_price.to_i * entry_size.to_i

    difference = exit_price.to_i - entry_price
    percent = difference / total_cost
    total_profit_loss = percent * total_cost

    total_profit_loss
  end

  def current_profit_loss(entry_price, exit_price, exit_size)
    total_cost = entry_price.to_i * exit_size.to_i

    difference = exit_price.to_i - entry_price
    percent = difference / total_cost
    profit_loss = percent * total_cost
    puts('calculation shit', profit_loss)

    profit_loss
  end
end
