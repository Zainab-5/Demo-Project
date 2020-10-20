class Transaction < ApplicationRecord
  belongs_to :buyer, foreign_key: 'user_id'
  belongs_to :subscription
end
