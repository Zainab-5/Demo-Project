class Plan < ApplicationRecord
  belongs_to :admin, foreign_key: 'user_id'
  has_and_belongs_to_many :features
  has_many :subscriptions, dependent: :delete_all
  has_many :buyers, through: :subscriptions, foreign_key: 'user_id'
  accepts_nested_attributes_for :features
  before_destroy {|plan| plan.features.clear}

  def calculate_bill
    @buyers = User.buyers
    @buyers.each do | buyer|
      buyer.subscriptions.each do |subscription|
         plan = Plan.find(subscription.plan_id)
         subscription.usages.each do |usage|
           @feature = Feature.find(usage.feature_id)
           if(usage.units_used > feature.max_limit)
             @exceeded_units = feature.max_limit - usage.units_used
             @over_use = (@exceeded_units*feature.unit_price)+ @over_use
           end
         end
         @over_use = @over_use + plan.fee
      end
       puts"#{@over_use}"
    end
  end
end
