class CalculationsController < ProtectedController
  before_action :set_user

  # Calculate total_profit_loss
  def buy_profit_loss(entry_price, exit_price, exit_size)
    total_cost = entry_price.to_d * exit_size.to_i

    difference = exit_price.to_d - entry_price.to_d

    percent = difference.to_d / entry_price.to_d
    profit_loss = percent * total_cost

    @user_balance += (profit_loss + total_cost)
    current_user.update(account_balance: @user_balance)

    profit_loss
  end

  def short_profit_loss(entry_price, exit_price, exit_size)
    total_cost = entry_price.to_d * exit_size.to_i

    difference = entry_price.to_d - exit_price.to_d
    percent = difference.to_d / entry_price.to_d
    profit_loss = percent * total_cost

    @user_balance += (profit_loss + total_cost)
    current_user.update(account_balance: @user_balance)

    profit_loss
  end

  def initial_transaction(entry_price, entry_size)
    if entry_size.to_i.positive?
      @user_balance -= entry_price * entry_size

    else @user_balance += entry_price * entry_size
    end
    current_user.update(account_balance: @user_balance)
  end
end

private

def set_user
  @user_balance = current_user.account_balance
end
