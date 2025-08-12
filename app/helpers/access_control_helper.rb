# app/helpers/access_control_helper.rb
module AccessControlHelper
  def access_permissions
    {
      full_admin: {
        bots: %w[index show create update destroy import_from_excel],
        users: %w[index show create update destroy import_from_excel],
        payments: %w[index show create update destroy import_from_excel],
        cryptos: %w[index show],
        companies: %w[index show create update destroy],
        products: %w[index show create update destroy],
        orders: %w[index show create update destroy],
        order_items: %w[index show create update destroy]
      },
      normal: {
        bots: %w[index show create update destroy import_from_excel],
        users: %w[show ],
        payments: %w[index show create update destroy import_from_excel],
        cryptos: %w[index show],
        companies: %w[show],
        products: %w[index show create update destroy],
        orders: %w[index show create update destroy],
        order_items: %w[index show create update destroy]
      }
    }
  end
end
