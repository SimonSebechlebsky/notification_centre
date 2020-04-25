# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Notification.create(
    id: 1,
    template_text: "Hello %s, welcome to Yova!",
    user_attributes: ["name"])
Notification.create(
    id: 2,
    template_text: "Hello, %s, you joined exactly one year ago at %s, here's a free 100$ gift card gift for your loyalty: tiny.cc/iqjmnz",
    user_attributes: ["name", "created_at"])

5.times do
  user = User.create(name: Faker::Name.unique.name.gsub(/\s+/, ""), password: 'muchsafeverysecret')
  UserNotification.create(
      user_id: user.id,
      notification_id: 1,
      seen: false
  )
  UserNotification.create(
      user_id: user.id,
      notification_id: 2,
      seen: false
  )
end

User.create(name: 'admin', password:'letmein', admin: true)
