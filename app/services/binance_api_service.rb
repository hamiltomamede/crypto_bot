require 'binance'

class BinanceApiService
    def initialize(api_key, secret_key)
      @client = Binance::Spot.new(api_key: api_key, secret_key: secret_key)
    end

    def get_balance
      @client.account["balances"]
    end

    def get_price(symbol)
      @client.ticker_price(symbol: symbol)
    end

    def create_order(symbol, side, quantity)
      @client.create_order(
        symbol: symbol,
        side: side,
        type: "MARKET",
        quantity: quantity
      )
    end
end
