# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# require 'date'

# user
10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

# task
20.times do |n|
  name = [*'A'..'Z'][rand(26)]
  detail = '仮詳細'
  deadline = Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
  status = rand(0..2)
  priority =  rand(0..2)
  user_id =  rand(1..2)
  Task.create!(name: name,
               detail: detail,
               deadline: deadline,
               status: status,
               priority: priority,
               user_id: user_id,
               )
end

# label
Label.create(name: '国語')
Label.create(name: '算数')
Label.create(name: '理科')
Label.create(name: '社会')
Label.create(name: '英語')
Label.create(name: '日課')
Label.create(name: '勉強会')
Label.create(name: '授業')
Label.create(name: 'プログラミング')
Label.create(name: 'トレーニング')
