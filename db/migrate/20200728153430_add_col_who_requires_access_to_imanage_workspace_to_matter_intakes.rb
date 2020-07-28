class AddColWhoRequiresAccessToImanageWorkspaceToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :who_requires_access_to_imanage_workspace, :string
  end
end
