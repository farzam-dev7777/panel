class CreateTechnologies < ActiveRecord::Migration[5.0]
  def change
    create_table :technology_values do |t|
      t.string :platform_category
      t.string :type
      t.string :vendor
      t.string :platform
      t.string :version
      t.string :service_pack
      t.string :supported

      t.timestamps
    end
  end
end
