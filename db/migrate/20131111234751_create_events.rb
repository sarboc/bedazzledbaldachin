class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.boolean :event_status
      t.datetime :start_time
      t.datetime :end_time
      t.string :wordnik
      t.references :party_type
      t.references :rating

      t.timestamps
    end
  end
end
