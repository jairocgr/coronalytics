class AddReportColumnToSrag < ActiveRecord::Migration[7.0]
  def change
    add_column :srags, :report, :text
  end
end
