class AddActivationTokenToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :activation_token, :string
  end
end
