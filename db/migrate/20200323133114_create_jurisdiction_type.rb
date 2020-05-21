class CreateJurisdictionType < ActiveRecord::Migration[5.0]
  def change
    create_table :jurisdiction_types do |t|
      t.string :jurisdiction_type
      t.timestamps
    end
  end
end
