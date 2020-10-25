class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :usages
  accepts_nested_attributes_for :plan
  after_create :create_transaction
  validates :user_id, :plan_id, presence: true

  private

  def create_transaction
    ActiveRecord::Base.transaction do
      @plan = Plan.find(plan_id)
      Transaction.create!(fee_charged: @plan.fee, subscription_id: id, user_id: user_id)
    end
  end
end
