class ChangeDefaultCounterOfAccessCounters < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:access_codes, :access_counter, 0)
    change_column_null(:access_codes, :access_counter, false, 0)
  end
end
