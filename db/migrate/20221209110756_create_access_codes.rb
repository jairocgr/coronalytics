class CreateAccessCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :access_codes do |t|
      t.string :name
      t.string :code

      t.timestamps
    end
  end
end
