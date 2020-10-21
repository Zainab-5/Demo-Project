class ChangeBillingDayToBeDate < ActiveRecord::Migration[5.2]
  def change
    remove_column :subscriptions, :billing_date
    add_column :subscriptions, :billing_date, :date
  end

end
