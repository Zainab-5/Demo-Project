class RemovePlansFromFeatures < ActiveRecord::Migration[5.2]
  def change
    remove_reference :features, :plan, foreign_key: true
  end
end
