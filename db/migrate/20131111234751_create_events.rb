class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :event_status, default: TRUE
      t.datetime :start_time
      t.datetime :end_time
      t.string :wordnik
      t.references :party_type
      t.references :rating
      t.references :user

      t.timestamps
    end
  end
end
