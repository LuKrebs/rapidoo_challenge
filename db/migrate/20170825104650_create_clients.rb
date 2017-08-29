class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients do |t|
      t.string :name
      t.string :email
      t.string :company_name
      t.float :monthly_revenue
      t.float :asset_value
      t.date :due_date

      t.timestamps
    end
  end
end
