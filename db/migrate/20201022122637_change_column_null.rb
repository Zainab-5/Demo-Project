# frozen_string_literal: true

class ChangeColumnNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :name, false
    change_column_null :users, :type, false
    change_column_null :features, :name, false
    change_column_null :features, :code, false
    change_column_null :features, :unit_price, false
    change_column_null :features, :max_limit, false
    change_column_null :features_plans, :plan_id, false
    change_column_null :features_plans, :feature_id, false
    change_column_null :plans, :user_id, false
    change_column_null :plans, :name, false
    change_column_null :plans, :fee, false
    change_column_null :subscriptions, :user_id, false
    change_column_null :subscriptions, :plan_id, false
    change_column_null :subscriptions, :billing_date, false
    change_column_null :transactions, :user_id, false
    change_column_null :transactions, :subscription_id, false
    change_column_null :transactions, :fee_charged, false
    change_column_null :usages, :feature_id, false
    change_column_null :usages, :subscription_id, false
    change_column_null :usages, :units_used, false
  end
end
