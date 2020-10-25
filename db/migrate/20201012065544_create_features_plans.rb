# frozen_string_literal: true

class CreateFeaturesPlans < ActiveRecord::Migration[5.2]
  def change
    create_table :features_plans do |t|
      t.references :plan, foreign_key: true
      t.references :feature, foreign_key: true
    end
  end
end
