class AddCompanyToUsers < ActiveRecord::Migration[7.2]
  def up
    add_reference :users, :company, foreign_key: true, null: true

    # define uma company padrão
  default_company = Company.first || Company.create!(name: "Default Company", email:"company@mail.com")

    User.update_all(company_id: default_company.id)

    change_column_null :users, :company_id, false
  end

  def down
    remove_reference :users, :company, foreign_key: true
  end
end
