class AddActiveToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :active, :boolean, default: false, null: false
    add_column :users, :activation_date, :datetime
  end
end
