# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.connection.tables.each do |t|
  ActiveRecord::Base.connection.reset_pk_sequence!(t)
end

notification1 = Notification.create(
    template_text: "Hello %s, welcome to Yova!",
    user_attributes: ["name"])
notification2 = Notification.create(
    template_text: "Hello, %s, you joined exactly one year ago at %s, here's a free 100$ gift card gift for your loyalty: tiny.cc/iqjmnz",
    user_attributes: ["name", "created_at"])

5.times do
  user = User.create(name: Faker::Name.unique.name.gsub(/\s+/, ""), password: 'muchsafeverysecret')
  UserNotification.create(
      user_id: user.id,
      notification_id: notification1.id,
      seen: false
  )
  UserNotification.create(
      user_id: user.id,
      notification_id: notification2.id,
      seen: false
  )
end

User.create(name: 'admin', password:'letmein', admin: true)
