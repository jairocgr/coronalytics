class AddAccessCounterAndActiveFlagToAccessCode < ActiveRecord::Migration[7.0]
  def change
    add_column :access_codes, :access_counter, :integer
    add_column :access_codes, :active, :boolean, default: true, null: false
  end
end
