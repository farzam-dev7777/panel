class AddColInitialDateOfEngagementWithTheBankToLawFirmsTenants < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms_tenants, :initial_date_of_engagement_with_the_bank, :datetime
  end
end
