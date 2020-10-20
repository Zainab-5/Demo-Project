class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :usages
  accepts_nested_attributes_for :plan
  after_save :create_transaction

  private
  def create_transaction
    ActiveRecord::Base.transaction do
     @plan = Plan.find(plan_id)
     @transaction = Transaction.create(fee_charged: @plan.fee, subscription_id: id, user_id: user_id)
    end
  end
end
