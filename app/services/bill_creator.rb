class BillCreator
  def calculate_bill
    buyers = Buyers.all
    @over_use = 0
    buyers.subscriptions.each do |subscription|
      if subscription.billing_date == Date.today.day
        plan = Plan.find(subscription.plan_id)
        @usages = subscription.usages
        @usages.each do |usage|
          @feature = Feature.find(usage.feature_id)
          if(usage.units_used.to_i > @feature.max_limit)
            @exceeded_units = usage.units_used-@feature.max_limit
            @over_use = (@exceeded_units*@feature.unit_price)+ @over_use
          end
        end
        @over_use = @over_use + plan.fee
      end
    end
    @over_use
  end
end
