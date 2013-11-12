class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.string :description
      t.string :category_type
      t.string :requirements
      t.integer :rating_id

      t.timestamps
    end
  end
end
