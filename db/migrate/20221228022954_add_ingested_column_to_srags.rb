class AddIngestedColumnToSrags < ActiveRecord::Migration[7.0]
  def change
    add_column :srags, :ingested, :boolean, default: false, null: false
  end
end
