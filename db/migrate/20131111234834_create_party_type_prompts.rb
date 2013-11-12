class CreatePartyTypePrompts < ActiveRecord::Migration
  def change
    create_table :party_type_prompts do |t|
      t.integer :prompt_id
      t.integer :party_type_id

      t.timestamps
    end
  end
end
