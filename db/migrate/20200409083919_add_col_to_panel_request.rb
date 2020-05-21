class AddColToPanelRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :panel_requests, :status, :string
    add_column :panel_requests, :lxp_status, :string
    add_column :panel_requests, :lxp_id, :integer
    add_column :panel_requests, :docusign_envelope_id, :string
    add_column :panel_requests, :notes, :text
  end
end
