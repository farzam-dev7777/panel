class AddPanelRetainerTemplateIdToTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :tenants, :panel_retainer_template_id, :string
  end
end
