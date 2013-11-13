class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.references :event
      t.string :name
      t.string :phone
      t.datetime :start_time
      t.datetime :end_time
      t.integer :user_passes, default: 0
      t.boolean :accepted, default: false
      t.timestamps
    end
  end
end
