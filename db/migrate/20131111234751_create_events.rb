class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :event_status
      t.datetime :start_time
      t.datetime :end_time
      t.string :wordnik
      t.integer :party_type_id
      t.integer :rating_id

      t.timestamps
    end
  end
end
