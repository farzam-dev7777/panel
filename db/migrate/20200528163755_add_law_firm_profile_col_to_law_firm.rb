class AddLawFirmProfileColToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :secondary_rm_contact, :string
    add_column :law_firms, :secondary_rm_contact_email, :string
    add_column :law_firms, :billing_contact_name, :string
    add_column :law_firms, :billing_contact_email, :string
    add_column :law_firms, :information_security_contact, :string
    add_column :law_firms, :information_security_contact_email, :string
    add_column :law_firms, :diverse, :string
    add_column :law_firms, :value_add_activities, :string
    add_column :law_firms, :feedback, :string
    add_column :law_firms, :issues, :string
    add_column :law_firms, :merger_combination, :string
    add_column :law_firms, :engagement_number, :string
    add_column :law_firms, :relationship_number, :string
    add_column :law_firms, :information_security_class, :string
    add_column :law_firms, :information_security_assessment_outcome, :string
    add_column :law_firms, :action_plan_findings, :string
    add_column :law_firms, :action_plan_status, :string
  end
end