class CreateMatterTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_types do |t|
      t.string :matter_type
      t.timestamps
    end
  end
end

 
