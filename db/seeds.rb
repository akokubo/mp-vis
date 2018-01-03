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
random = Random.new()
50.times do
  users.each { |user| user.places.create!(
    name: Faker::Lorem.sentence(5),
    description: Faker::Lorem.sentence(20),
    mass: (random.rand(10.0)).round(3),
    latitude: (random.rand((-90.0)..(90.0))).round(7),
    longitude: (random.rand((-180.0)..(180.0))).round(7),
    collected_at: Time.zone.now)
  }
end
