class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :amount, precision: 10, scale: 2
      t.string :status
      t.datetime :payment_date
      t.datetime :expires_at
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
