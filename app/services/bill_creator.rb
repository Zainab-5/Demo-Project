class BillCreator
  def calculate_bill(subscription_id)
    subscription = Subscription.find(subscription_id)
    user = subscription.user
    plan = subscription.plan
    usages = subscription.usages
    transaction = Transaction.find_by(subscription_id: subscription.id)
    difference = Date.today - transaction.created_at.to_date
    @over_use = 0

    if(subscription.billing_date.day == Date.today.day) || (difference > 30)
      usages.each do |usage|
        feature = Feature.find(usage.feature_id)
        if(usage.units_used > feature.max_limit)
          @exceeded_units = usage.units_used - feature.max_limit
          @over_use = (@exceeded_units*feature.unit_price)+ @over_use
        end
      end

      chargeable_amount = plan.fee + @over_use
      ActiveRecord::Base.transaction do
        @transaction = Transaction.create(fee_charged: chargeable_amount, subscription_id: subscription.id, user_id: user.id)
      end
    end
  end
end
