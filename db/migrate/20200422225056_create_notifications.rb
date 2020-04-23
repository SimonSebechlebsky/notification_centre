class CreateNotifications < ActiveRecord::Migration[5.2]
  def change
    create_table :notifications do |t|
      t.string :template_text
      t.string :user_attributes, array: true, default: []

      t.timestamps
    end
  end
end
