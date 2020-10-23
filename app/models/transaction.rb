class Transaction < ApplicationRecord
  belongs_to :buyer, foreign_key: 'user_id'
  belongs_to :subscription
  validates :user_id, :subscription_id, :fee_charged, presence: true
end
