# app/workers/crypto_worker.rb
require "httparty"

class CryptoWorker
  include Sidekiq::Worker

  def perform
    response = HTTParty.get("https://api.coingecko.com/api/v3/coins/markets", query: {
      vs_currency: "usd",
      order: "market_cap_desc",
      per_page: 12,
      page: 1
    })

    response.each do |coin|
      Crypto.find_or_initialize_by(symbol: coin["symbol"].upcase).update(
        name: coin["name"],
        image: coin["image"],
        market_cap: coin["market_cap"],
        volume: coin["total_volume"],
        price: coin["current_price"],
        price_change_24h: coin["price_change_percentage_24h"]
      )
    end
  end
end
