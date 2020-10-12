class Buyer < User
  has_many :subscriptions, foreign_key: 'user_id'
  has_many :plans, through: :subscriptions
end
