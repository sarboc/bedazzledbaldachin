class CreatePrompts < ActiveRecord::Migration
  def change
    create_table :prompts do |t|
      t.text :description
      t.text :requirements
      t.references :rating

      t.timestamps
    end
  end
end
