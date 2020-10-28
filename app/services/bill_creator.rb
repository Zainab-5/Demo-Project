# frozen_string_literal: true

class BillCreator

  def initialize(subscription_id)
    @subscription = Subscription.find(subscription_id)
    @user = @subscription.user
    @plan = @subscription.plan
    @usages = @subscription.usages.where(is_billed: false)
    transaction = Transaction.where(subscription_id: subscription_id).last
    @difference = Date.today - transaction.created_at.to_date
    @last_day = (Date.today - Date.today.day).day
    @over_use = 0
    @check = false
  end

  def calculate_bill
    if ((@subscription.billing_date.day == Date.today.day) && (@difference >= @last_day)) || (@difference >= @last_day)
      @usages.each do |usage|
        feature = Feature.find(usage.feature_id)
        if usage.units_used > feature.max_limit
          exceeded_units = usage.units_used - feature.max_limit
          @over_use = (exceeded_units * feature.unit_price) + @over_use
        end
        usage.toggle(:is_billed)
        end
        @chargeable_amount = @plan.fee + @over_use
        make_transaction
        @check = true
    end
    @check
  end

  private

  def make_transaction
    ActiveRecord::Base.transaction do
      Transaction.create!(fee_charged: @chargeable_amount, subscription_id: @subscription.id,
                          user_id: @user.id, created_via_subscriptions: false)
    end
    check = true
 end
end
