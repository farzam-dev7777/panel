class AddInitialDateOfEngagementToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :initial_date_of_engagement_with_the_bank, :datetime
    add_column :law_firms, :type_of_matters_your_law_firm_handles_for_us, :text
    add_column :law_firms, :type_of_services_your_law_firm_provides_generally, :text
    add_column :law_firms, :confidentiality_level_of_matters_that_are_handled, :text
    add_column :law_firms, :number_of_lawyers, :string
  end
end
