class CreateSrags < ActiveRecord::Migration[7.0]
  def change
    create_table :srags do |t|
      t.integer :year
      t.date    :release_date
      t.string  :url

      t.timestamps
    end
  end
end
