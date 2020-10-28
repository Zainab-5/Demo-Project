class AddBillingToUsages < ActiveRecord::Migration[5.2]
  def change
    add_column :usages, :is_billed, :boolean, default: false
  end
end
