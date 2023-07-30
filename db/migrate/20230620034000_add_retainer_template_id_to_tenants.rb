class AddRetainerTemplateIdToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :retainer_template_id, :string
  end
end
