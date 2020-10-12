class Admin < User
  has_many :plans, foreign_key: 'user_id'

end
