class AddColBmoRelationshipPartnerPhoneNumberToLawFirms < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :bmo_relationship_partner_phone_number, :string
  end
end
