class CreateTenants < ActiveRecord::Migration[5.0]
  def change
    create_table :tenants do |t|
      t.string :name
      t.string :subdomain, unique: true
      t.string :logo
      t.string :primary_color
      t.string :secondary_color
      t.string :login_bg_image

      t.timestamps
    end
  end
end
