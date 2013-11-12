class CreateEventPrompts < ActiveRecord::Migration
  def change
    create_table :event_prompts do |t|
      t.integer :event_id
      t.integer :prompt_id
      t.integer :user_event_id
      t.boolean :completed
      t.boolean :passed

      t.timestamps
    end
  end
end
