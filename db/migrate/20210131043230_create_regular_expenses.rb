class CreateRegularExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :regular_expenses do |t|
      t.references :admin_user, null: false, foreign_key: true
      t.references :expense_type, null: false, foreign_key: true
      t.string :name
      t.decimal :price, precision: 9, scale: 0

      t.timestamps
    end
  end
end
