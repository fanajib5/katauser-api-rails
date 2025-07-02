# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
# Create admin user
admin = User.find_or_create_by(email: 'admin@example.com') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
  user.first_name = 'Admin'
  user.last_name = 'User'
  user.admin = true
end

puts "Created admin user: #{admin.email}"

# Create regular users
5.times do |i|
  user = User.find_or_create_by(email: "user#{i+1}@example.com") do |u|
    u.password = 'password123'
    u.password_confirmation = 'password123'
    u.first_name = "User"
    u.last_name = "#{i+1}"
    u.admin = false
  end
  puts "Created user: #{user.email}"
end

puts "Seeding completed!"
puts "Total users: #{User.count}"
