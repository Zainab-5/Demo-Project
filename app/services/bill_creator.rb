# frozen_string_literal: true

class BillCreator
  def calculate_bill(subscription_id)
    subscription = Subscription.find(subscription_id)
    return false unless subscription

    user = subscription.user
    plan = subscription.plan
    usages = subscription.usages
    transaction = Transaction.where(subscription_id: subscription_id).last
    difference = Date.today - transaction.created_at.to_date
    @over_use = 0
    check = false

    #add check for the double subscription for single day.
    if ((subscription.billing_date.day == Date.today.day) && (difference >= 30)) || (difference >= 30)
      usages.each do |usage|
        feature = Feature.find(usage.feature_id)
        if usage.units_used > feature.max_limit
          @exceeded_units = usage.units_used - feature.max_limit
          @over_use = (@exceeded_units * feature.unit_price) + @over_use
        end
      end

      chargeable_amount = plan.fee + @over_use
      ActiveRecord::Base.transaction do
        @transaction = Transaction.create(fee_charged: chargeable_amount, subscription_id: subscription.id, user_id: user.id)
        TransactionMailer.with(transaction: @transaction).new_transaction_email.deliver_later
      end
      check = true
    end
    check
  end
end
