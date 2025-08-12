class CreateCryptos < ActiveRecord::Migration[7.2]
  def change
    create_table :cryptos do |t|
      t.string :name
      t.string :symbol
      t.integer :market_cap
      t.integer :volume
      t.float :rsi
      t.float :sentiment
      t.float :score

      t.timestamps
    end
  end
end
