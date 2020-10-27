# frozen_string_literal: true

class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :plan
  has_many :usages
  accepts_nested_attributes_for :plan

  after_create :create_transaction

  validates :user_id, :plan_id, presence: true

  protected

  def create_transaction
    ActiveRecord::Base.transaction do
      plan = Plan.find(plan_id)
      subscription = Subscription.find(id)
      # SubscriptionMailer.with(subscription: subscription).new_subscription_email.deliver
      Transaction.create!(fee_charged: plan.fee, subscription_id: id, user_id: user_id, created_via_subscriptions: true)
    end
  end

  public

  def usage_used(feature_id)
    usages.find_by(feature_id: feature_id)&.units_used.to_i
  end
end
