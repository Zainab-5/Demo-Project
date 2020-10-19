class Admin < User
  has_many :plans, foreign_key: 'user_id'

  def calculate_bill
    @buyers = User.buyers
    @over_use = 0
    buyer.subscriptions.each do |subscription|
        plan = Plan.find(subscription.plan_id)
        @usages = subscription.usages
        @usages.each do |usage|
          @feature = Feature.find(usage.feature_id)
          #puts "#{@feature.max_limit}"
          if(usage.units_used.to_i > @feature.max_limit)
           # puts "#{usage.units_used}"
           # puts "#{@feature.unit_price}"
            @exceeded_units = usage.units_used-@feature.max_limit
            puts "#{@exceeded_units}"
            @over_use = (@exceeded_units*@feature.unit_price)+ @over_use
          end
        end
        @over_use = @over_use + plan.fee
    end
    #puts"#{@over_use}"
  end
end
