class Payment < ApplicationRecord
  belongs_to :user

  validates :status, :amount, :payment_date, presence: true
end
