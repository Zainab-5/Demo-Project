class CreateUsages < ActiveRecord::Migration[5.2]
  def change
    create_table :usages do |t|
      t.integer :units_used
      t.references :subscription, foreign_key: true
      t.references :feature, foreign_key: true

      t.timestamps
    end
  end
end
