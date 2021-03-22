class ChangeColsInMatterIntakes < ActiveRecord::Migration[5.0]
  def up
    change_column :matter_intakes, :is_syndicate_matter, :string, :using => "case when is_syndicate_matter then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :arbitration_offered, :string, :using => "case when arbitration_offered then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :arbitration_accepted, :string, :using => "case when arbitration_accepted then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :unquantified_claim, :string, :using => "case when unquantified_claim then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :is_conceal_imanage_workspace, :string, :using => "case when is_conceal_imanage_workspace then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :is_paper_file, :string, :using => "case when is_paper_file then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :can_reimbursed_matter, :string, :using => "case when can_reimbursed_matter then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :allegation_of_employee_misconduct, :string, :using => "case when allegation_of_employee_misconduct then 'Yes' else 'No' end", default: nil
  end

  def down
    change_column :matter_intakes, :is_syndicate_matter, 'boolean USING CAST(is_syndicate_matter AS boolean)', default: nil
    change_column :matter_intakes, :arbitration_offered, 'boolean USING CAST(arbitration_offered AS boolean)', default: nil
    change_column :matter_intakes, :arbitration_accepted, 'boolean USING CAST(arbitration_accepted AS boolean)', default: nil
    change_column :matter_intakes, :unquantified_claim, 'boolean USING CAST(unquantified_claim AS boolean)', default: nil
    change_column :matter_intakes, :is_conceal_imanage_workspace, 'boolean USING CAST(is_conceal_imanage_workspace AS boolean)', default: nil
    change_column :matter_intakes, :is_paper_file, 'boolean USING CAST(is_paper_file AS boolean)', default: nil
    change_column :matter_intakes, :can_reimbursed_matter, 'boolean USING CAST(can_reimbursed_matter AS boolean)', default: nil
    change_column :matter_intakes, :allegation_of_employee_misconduct, 'boolean USING CAST(allegation_of_employee_misconduct AS boolean)', default: nil
  end
end
