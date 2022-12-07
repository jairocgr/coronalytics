class AddDownloadedToSragFile < ActiveRecord::Migration[7.0]
  def change
    add_column :srags, :downloaded, :boolean, default: false, null: false
  end
end
