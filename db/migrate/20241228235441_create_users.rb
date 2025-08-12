# migration to create user table
class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, null: false, index: { unique: true }
      t.string :password
      t.string :password_digest
      t.string :remember_token
      t.integer :role, default: 0, null: false
      t.boolean :active, default: true

      t.timestamps
    end
    add_index :users, :remember_token
  end
end
