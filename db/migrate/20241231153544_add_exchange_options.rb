class AddExchangeOptions < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :api_key, :string
    add_column :users, :secret, :string
  end
end
