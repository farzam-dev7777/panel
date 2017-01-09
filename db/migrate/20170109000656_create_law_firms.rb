class CreateLawFirms < ActiveRecord::Migration[5.0]
  def change
    create_table :law_firms do |t|
      t.string :name
      t.string :description
      t.string :email
      t.string :phone

      t.timestamps
    end
  end
end
