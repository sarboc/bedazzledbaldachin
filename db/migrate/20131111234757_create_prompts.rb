class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.text :description
      t.text :requirements
      t.integer :rating_id

      t.timestamps
    end
  end
end
