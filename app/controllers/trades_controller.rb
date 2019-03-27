class TradesController < CalculationsController
  before_action :set_trade, only: %i[show update destroy]
  before_action :update_params, only: :update

  # GET /trades
  def index
    @trades = current_user.trades.where('open = true')

    render json: { trades: @trades, account_balance: current_user.account_balance }
  end

  def index_closed
    @trades = current_user.trades.where('open = false')

    render json: @trades
  end

  # GET /trades/1
  def show
    render json: @trade
  end

  # POST /trades
  def create
    @trade = current_user.trades.new(trade_params)
    trade_info = trade_params
    initial_transaction(trade_info['entry_price'].to_d, trade_info['entry_size'].to_i)
    trade_info['account_balance'] = current_user.account_balance

    trade_info['id'] = @trade.attributes['id'].to_i
    if @trade.save
      render json: trade_info
    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trades/1
  def update
    # only accept open trades
    if @trade.attributes['open'] == false
      render json: @trade.errors, status: :unprocessable_entity

      # execute full size trade (buy/sell)
    elsif @trade.attributes['entry_size'].to_i == @update_params['exit_size'].to_i
    total_profit_loss = buy_profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @update_params['exit_size'])
    @update_params['total_profit_loss'] = total_profit_loss
    @update_params['open'] = false

    @trade.update(@update_params)
    puts @update_params
    @update_params['account_balance'] = current_user.account_balance
    render json: @update_params

      # execute partial trade (buy/sell)
    elsif @trade.attributes['entry_size'].to_i > @update_params['exit_size'].to_i
      @update_params['entry_size'] = @trade.attributes['entry_size'].to_i - @update_params['exit_size'].to_i
      current_profit_loss = buy_profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @update_params['exit_size'])

      @update_params['total_profit_loss'] = @trade.attributes['total_profit_loss'].to_d + current_profit_loss
      @update_params['open'] = true

      @trade.update(@update_params)
      @update_params['account_balance'] = current_user.account_balance
      render json: @update_params

      # execute full size trade (short/cover)
    elsif @trade.attributes['entry_size'].to_i * -1 == @update_params['exit_size'].to_i
    total_profit_loss = short_profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @update_params['exit_size'])
    @update_params['total_profit_loss'] = total_profit_loss
    @update_params['open'] = false

    @trade.update(@update_params)
    @update_params['account_balance'] = current_user.account_balance
    render json: @update_params

      # execute partial size trade (short/cover)
    elsif @trade.attributes['entry_size'].to_i * -1 > @update_params['exit_size'].to_i
    @update_params['entry_size'] = @trade.attributes['entry_size'].to_i + @update_params['exit_size'].to_i
    total_profit_loss = short_profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @update_params['exit_size'])
    @update_params['total_profit_loss'] = @trade.attributes['total_profit_loss'].to_d + total_profit_loss
    @update_params['open'] = true

    @trade.update(@update_params)
    @update_params['account_balance'] = current_user.account_balance
    render json: @update_params

    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trades/1
  def destroy
    @trade.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_trade
    @trade = current_user.trades.find(params[:id])

    @trade
  end

  def update_params
    @update_params = trade_params
  end

  # Only allow a trusted parameter "white list" through.
  def trade_params
    params.require(:trade).permit(:ticker_symbol, :entry_price, :exit_price, :entry_size, :exit_size, :open)
  end
end
