class CreateTechnologiesList < ActiveRecord::Migration[5.0]
  def change
    create_table :technologies do |t|
      t.string :vendor
      t.string :platform
      t.string :version
      t.string :service_pack
      t.string :supported

      t.timestamps
    end
  end
end
