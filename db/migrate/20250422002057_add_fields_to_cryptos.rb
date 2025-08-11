class AddFieldsToCryptos < ActiveRecord::Migration[7.2]
  def change
    add_column :cryptos, :image, :string
    add_column :cryptos, :price, :decimal
    add_column :cryptos, :price_change_24h, :float
  end
end
