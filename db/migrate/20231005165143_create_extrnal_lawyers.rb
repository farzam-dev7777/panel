class CreateExtrnalLawyers < ActiveRecord::Migration[5.0]
  def change
    create_table :external_lawyers do |t|
      t.integer :law_firm_id
      t.string :name
      t.timestamps
    end
  end
end
