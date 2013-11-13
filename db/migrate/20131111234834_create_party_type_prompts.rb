class CreatePartyTypePrompts < ActiveRecord::Migration
  def change
    create_table :party_type_prompts do |t|
      t.references :prompt
      t.references :party_type

      t.timestamps
    end
  end
end
