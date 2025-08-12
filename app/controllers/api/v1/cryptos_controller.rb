class Api::V1::CryptosController < ApplicationController
    def index
          cryptos = Crypto.where("name LIKE ?", "%#{params[:search]}%")
                          .where("price >= ?", params[:minPrice])
                          .where("price <= ?", params[:maxPrice])
          render json: cryptos
    end

    def price_history
          crypto = Crypto.find(params[:id])
          render json: crypto.price_history
    end


    def show
      crypto = Crypto.find_by(symbol: params[:id].upcase)
      if crypto
        render json: crypto
      else
        render json: { error: "Crypto not found" }, status: :not_found
      end
    end
end
