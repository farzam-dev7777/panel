class RenameColLobIdToLxpIdToMatterIntakes < ActiveRecord::Migration[5.0]
  def up
    rename_column :matter_intakes, :lob_id, :lxp_id
  end

  def down
    rename_column :matter_intakes, :lxp_id, :lob_id
  end
end
