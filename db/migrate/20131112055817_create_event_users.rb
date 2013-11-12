class CreateEventUsers < ActiveRecord::Migration
  def change
    create_table :event_users do |t|
      t.references :user
      t.references :event
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_passes, default: 0
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
