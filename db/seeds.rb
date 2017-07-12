
require 'random_data'
25.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    role: [:standard, :premium, :admin].sample,
    password: Faker::Internet.password(8)
  )
end
users = User.all

150.times do
  Wiki.create!(
    user: users.sample,
    title: Faker::Hipster.word.titlecase,
    body: Faker::Hipster.paragraph(4, false),
    private: RandomData.random_boolean
  )
end
wikis = Wiki.all

puts "Seeds finished!"
puts "#{Wiki.count} wikis created"
puts "#{User.count} users created"
