class CreateAdminUser < ActiveRecord::Migration[7.0]
  def up
    User.create!({
      name: 'Super Admin',
      email: 'admin@coronalytics.info',
      password: 'admin',
      password_confirmation: 'admin',
      active: true,
      activation_date: DateTime.now
    })
  end
end
