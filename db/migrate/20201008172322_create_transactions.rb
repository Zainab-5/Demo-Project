class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :subscription, foreign_key: true
      t.integer :fee_charged

      t.timestamps
    end
  end
end
