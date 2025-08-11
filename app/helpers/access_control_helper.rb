# app/helpers/access_control_helper.rb
module AccessControlHelper
  def access_permissions
    {
      full_admin: {
        bots: %w[index show create update destroy import_from_excel],
        users: %w[index show create update destroy import_from_excel],
        payments: %w[index show create update destroy import_from_excel],
        cryptos: %w[index show]
      },
      normal: {
        bots: %w[index show create update destroy import_from_excel],
        users: %w[show ],
        payments: %w[index show create update destroy import_from_excel],
        cryptos: %w[index show]
      }
    }
  end
end
