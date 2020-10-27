# frozen_string_literal: true

class TransactionMailer < ApplicationMailer
  def new_transaction_email(id)
    transaction = Transaction.find(id)
    mail(to: transaction.subscription.user.email, subject: "Your bill has been processed ! '#{transaction.fee_charged}'")
  end

  def new_subscription_email
    mail(to: transaction.subscription.user.email, subject: 'You made a new subscription!')
  end
end
