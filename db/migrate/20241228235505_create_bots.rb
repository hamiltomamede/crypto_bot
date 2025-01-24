class CreateBots < ActiveRecord::Migration[7.1]
  def change
    create_table :bots do |t|
      t.references :user, null: false, foreign_key: true
      t.string :symbol
      t.string :strategy
      t.decimal :minimum_balance, precision: 10, scale: 2
      t.decimal :maximum_trade_size, precision: 10, scale: 2
      t.string :status, default: 'active'
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
