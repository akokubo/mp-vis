User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end

# 6人分のマイクロポストを50件ずつ生成する
users = User.order(:created_at).take(6)
50.times do
  name = Faker::Lorem.sentence(5)
  description = Faker::Lorem.sentence(20)
  mass = Random.rand(10.0).round(3)
  latitude = Random.rand(-90.0 .. 90.0).round(7)
  longitude = Random.rand(-180.0 .. 180.0).round(7)
  collected_at = Time.zone.now
  users.each { |user| user.places.create!(name: name, description: description, mass: mass, latitude: latitude, longitude: longitude, collected_at: collected_at) }
end

# Following relationships
# 最初のユーザーが2から50番目をフォローし、3から40番目からフォローさせる
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
