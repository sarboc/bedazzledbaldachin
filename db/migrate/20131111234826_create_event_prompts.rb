class CreateEventPrompts < ActiveRecord::Migration
  def change
    create_table :event_prompts do |t|
      t.references :event
      t.references :prompt
      t.references :user_event #do we use this in the MVP?
      t.boolean :completed, default: false
      t.boolean :passed, default: false
      t.timestamps
    end
  end
end
