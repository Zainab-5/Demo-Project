class AddUniqueIndex < ActiveRecord::Migration[5.2]
  def change
    add_index(:subscriptions, [:plan_id, :user_id], :unique => true)
    add_index(:features_plans, [:plan_id, :feature_id], :unique => true)
  end
end
