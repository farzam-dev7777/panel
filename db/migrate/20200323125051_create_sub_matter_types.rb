class CreateSubMatterTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :sub_matter_types do |t|
      t.string :sub_matter_type
      t.integer :matter_type_id
      t.timestamps
    end
  end
end
