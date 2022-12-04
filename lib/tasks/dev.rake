
require 'faker'

namespace :dev do

  DEFAULT_PASSWD = "588FD122E65C4"
  N_USERS = 128

  desc "Seed development env with basic data"
  task seed: :environment do
    seed_users
  end

  def seed_users
    puts "Seeding users..."

    # Removes all users but the first
    User.where('id != 1').destroy_all

    N_USERS.times do
      User.create!({
        name: Faker::Name.unique.name,
        email: Faker::Internet.unique.email,
        password: DEFAULT_PASSWD,
        password_confirmation: DEFAULT_PASSWD,
        active: true,
        activation_date: DateTime.now
      })
    end

    puts "#{N_USERS} new users sown for development"
  end

end
