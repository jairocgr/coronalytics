class CreateVaccinationNumbers < ActiveRecord::Migration[7.0]
  def change
    create_table :vaccination_numbers do |t|
      t.integer :year, null: false
      t.integer :month, null: false
      t.decimal :one_dose, default: 0, null: false
      t.decimal :two_doses, default: 0, null: false
      t.decimal :boosted, default: 0, null: false
      t.string  :country, limit: 3, null: false

      t.timestamps
    end

    add_index(:vaccination_numbers, [:year, :month], unique: true)
  end
end
