class Bot < ApplicationRecord
  belongs_to :user

  enum status: { active: "active", paused: "paused", completed: "completed" }

  validates :symbol, :strategy, :minimum_balance, :maximum_trade_size, presence: true
end
