class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :event_status, default: TRUE
      t.datetime :start_time
      t.datetime :end_time
      t.string :wordnik
      t.integer :party_type_id
      t.integer :rating_id

      t.timestamps
    end
  end
end
