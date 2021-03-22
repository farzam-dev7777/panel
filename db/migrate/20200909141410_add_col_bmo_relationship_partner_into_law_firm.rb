class AddColBmoRelationshipPartnerIntoLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :bmo_relationship_partner_name, :string
    add_column :law_firms, :bmo_relationship_partner_email, :string
  end
end



