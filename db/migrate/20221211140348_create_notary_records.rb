class CreateNotaryRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :notary_records do |t|
      t.integer :year, index: { unique: true }
      t.integer :deaths
      t.boolean :pandemic_year

      t.timestamps
    end
  end
end
