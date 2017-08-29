class AddColumnsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :name, :string
    add_column :users, :company_name, :string
    add_column :users, :monthly_revenue, :float
    add_column :users, :asset_value, :float
    add_column :users, :due_date, :datetime
  end
end
