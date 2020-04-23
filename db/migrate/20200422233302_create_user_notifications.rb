class CreateUserNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :user_notifications do |t|
      t.boolean :seen
      t.references :notification, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
