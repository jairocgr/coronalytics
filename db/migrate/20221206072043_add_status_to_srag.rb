class AddStatusToSrag < ActiveRecord::Migration[7.0]
  def change
    add_column :srags, :status, :string, limit: 24, null: false, default: 'CREATED'
  end
end
