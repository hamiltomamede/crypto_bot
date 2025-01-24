# define User model and validations
class User < ApplicationRecord
  include Active

  has_many :bots
  has_many :payments

  has_secure_password
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token
  validates :name, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password, length: { minimum: 6 }, on: :update, allow_blank: true
  # validates :password_confirmation, presence: true, on: :create
  validate :password_lower_case, on: :create
  validate :password_uppercase, on: :create
  validate :password_contains_number, on: :create

  def password_contains_number
    return if /\d/.match?(password)

    errors.add(:password, 'must include at least one number')
  end

  def password_uppercase
    return if /\p{Upper}/.match?(password)

    errors.add(:password, 'must include at least one uppercase letter')
  end

  def password_lower_case
    return if /\p{Lower}/.match?(password)

    errors.add(:password, 'must include at least one lowercase letter')
  end

  def as_json(options = {})
    super(options.merge(except: %i[password remember_token password_digest]))
  end

  private

  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
