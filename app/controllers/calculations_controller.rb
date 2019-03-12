class CalculationsController < ProtectedController
  # Calculate total_profit_loss
  def buy_profit_loss(entry_price, exit_price, exit_size)
    total_cost = entry_price.to_i * exit_size.to_i

    difference = exit_price.to_i - entry_price.to_i
    percent = difference / entry_price
    profit_loss = percent * total_cost

    profit_loss
  end

  def short_profit_loss(entry_price, exit_price, exit_size)
    total_cost = entry_price.to_i * exit_size.to_i

    difference = entry_price.to_i - exit_price.to_i
    percent = difference / entry_price
    profit_loss = percent * total_cost
    puts('calculation shit', profit_loss)

    profit_loss
  end
end
