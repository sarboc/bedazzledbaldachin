class CreatePartyTypes < ActiveRecord::Migration
  def change
    create_table :party_types do |t|
      t.string :description
      t.timestamps
    end
  end
end
