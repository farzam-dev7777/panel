class AddColsToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :legal_group_of_bmo_lawyer, :string
    add_column :matter_intakes, :work_area, :string
    add_column :matter_intakes, :is_ore_reportable, :boolean, default: false
    add_column :matter_intakes, :is_otherwise_reportable, :boolean, default: false
    add_column :matter_intakes, :is_syndicate_matter, :boolean, default: false
    add_column :matter_intakes, :is_conceal_imanage_workspace, :boolean, default: false
    add_column :matter_intakes, :is_paper_file, :boolean, default: false
    add_column :matter_intakes, :jurisdiction, :string
    add_column :matter_intakes, :firm_type, :string
    add_column :matter_intakes, :name_of_panel_firm, :string
    add_column :matter_intakes, :name_of_non_panel_firm, :string
    add_column :matter_intakes, :type_of_price, :string
    add_column :matter_intakes, :is_alternative_fee_arrangement, :boolean, default: false
    add_column :matter_intakes, :afa_details, :string
    add_column :matter_intakes, :additional_matter_contact, :string
    add_column :matter_intakes, :other_matter_issues, :string
    add_column :matter_intakes, :lawyer_reviewed_at, :datetime
    add_column :matter_intakes, :other_party, :string
  end
end
