class CreateSharedBankInformations < ActiveRecord::Migration[5.0]
  def change
    create_table :shared_bank_informations do |t|
      t.integer :form_value_id
      t.string :name
      t.string :purpose
      t.string :level_of_access

      t.timestamps
    end
  end
end
