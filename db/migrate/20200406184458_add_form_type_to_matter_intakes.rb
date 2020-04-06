class AddFormTypeToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :form_type, :string
    add_column :matter_intakes, :branch, :string
    add_column :matter_intakes, :outside_counsel_engaged, :string
    add_column :matter_intakes, :can_reimbursed_matter, :boolean, default: false
    add_column :matter_intakes, :key_facts, :text
    add_column :matter_intakes, :legal_analysis, :string
    add_column :matter_intakes, :stage_of_litigation, :string
    add_column :matter_intakes, :allegation_of_employee_misconduct, :boolean, default: false
    add_column :matter_intakes, :primary_issue, :string
    add_column :matter_intakes, :secondary_issue, :string
    add_column :matter_intakes, :bmo_party, :string
    add_column :matter_intakes, :opposing_counsel_firm, :string
    add_column :matter_intakes, :written_legal_notice_required, :boolean, default: false
    add_column :matter_intakes, :arbitration_offered, :boolean, default: false
    add_column :matter_intakes, :arbitration_accepted, :boolean, default: false
    add_column :matter_intakes, :branch_manager_investment_advisor, :string
    add_column :matter_intakes, :date_suit_filed, :date
    add_column :matter_intakes, :unquantified_claim, :boolean, default: false
    add_column :matter_intakes, :valued_at, :string
    add_column :matter_intakes, :amount_claimed_from_bmo_1, :string
    add_column :matter_intakes, :amount_claimed_1_currency, :string
    add_column :matter_intakes, :amount_claimed_from_bmo_2, :string
    add_column :matter_intakes, :amount_claimed_2_currency, :string
    add_column :matter_intakes, :amount_claimed_by_bmo, :string
    add_column :matter_intakes, :amount_claimed_by_bmo_currency, :string
    add_column :matter_intakes, :breakdown_of_claim_amount, :string
    add_column :matter_intakes, :court_name, :string
    add_column :matter_intakes, :case_caption, :string
    add_column :matter_intakes, :docket_number, :string
    add_column :matter_intakes, :comset_issues, :string
    add_column :matter_intakes, :comset_ref, :string
    add_column :matter_intakes, :mi_matter, :string
    add_column :matter_intakes, :region_name, :string
    add_column :matter_intakes, :nature_of_events, :string
    add_column :matter_intakes, :process_type_level_1, :string
    add_column :matter_intakes, :process_type_level_2, :string
    add_column :matter_intakes, :product_type_level_1, :string
    add_column :matter_intakes, :product_type_level_2, :string
    add_column :matter_intakes, :event_type_level_1, :string
    add_column :matter_intakes, :event_type_level_2, :string
    add_column :matter_intakes, :business_activity_level_1, :string
    add_column :matter_intakes, :business_activity_level_2, :string
    add_column :matter_intakes, :court_type, :string
  end
end
