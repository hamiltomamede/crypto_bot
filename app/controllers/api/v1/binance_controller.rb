module Api
    module V1
        class BinanceController < ApplicationController
    def market_data
      data = BinanceService.fetch_market_data
      render json: data
    end
  
    def balance
      balance = BinanceService.fetch_user_balance(@current_user)
      render json: balance
    end
  end
end
end
