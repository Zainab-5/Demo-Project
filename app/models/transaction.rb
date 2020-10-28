# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :buyer, foreign_key: 'user_id'
  belongs_to :subscription
  validates :user_id, :subscription_id, :fee_charged, presence: true
  attr_accessor :created_via_subscriptions

  after_create :send_email

  private

  def send_email
    @transaction = Transaction.find(id)
    if created_via_subscriptions
      TransactionMailer.with(transaction: @transaction).new_subscription_email.deliver
    else
      TransactionMailer.with(transaction: @transaction).new_transaction_email.deliver
    end
  end
end
