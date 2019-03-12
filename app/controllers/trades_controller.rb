class TradesController < CalculationsController
  before_action :set_trade, only: [:show, :update, :destroy]
  before_action :update_params

  # GET /trades
  def index
    @trades = current_user.trades.all

    render json: @trades
  end

  # GET /trades/1
  def show
    render json: @trade
  end

  # POST /trades
  def create
    @trade = current_user.trades.new(trade_params)

    if @trade.save
      render json: @trade, status: :created, location: @trade
    else
      render json: @trade.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trades/1
  def update
    if @trade.attributes['open'] == false
      render json: @trade.errors, status: :unprocessable_entity

    elsif @trade.attributes['entry_size'].to_i == @update_params['exit_size'].to_i
    total_profit_loss = profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @trade.attributes['entry_size'])
    @update_params['total_profit_loss'] = @trade.attributes['total_profit_loss'].to_i + total_profit_loss.to_i
    @update_params['open'] = false

    @trade.update(@update_params)
    render json: @trade

    elsif @trade.attributes['entry_size'].to_i > @update_params['exit_size'].to_i
      @update_params['entry_size'] = @trade.attributes['entry_size'].to_i - @update_params['exit_size'].to_i
      current_profit_loss = current_profit_loss(@trade.attributes['entry_price'], @update_params['exit_price'], @update_params['exit_size'])

      @update_params['total_profit_loss'] = @trade.attributes['total_profit_loss'].to_i + current_profit_loss.to_i
      @update_params['open'] = true

      @trade.update(@update_params)
      render json: @trade
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
      params.require(:trade).permit(:ticker_symbol, :entry_price, :exit_price, :entry_size, :exit_size, :entry_date, :exit_date, :total_profit_loss, :open)
    end
end
