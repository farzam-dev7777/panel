class CreateMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    create_table :matter_intakes do |t|
      t.integer   :user_id   # [LOB, LAWYER]
      t.string    :submitter_name
      t.string    :lob_contact_name
      t.string    :name_of_matter_client
      t.integer   :matter_type_id
      t.text      :matter_description
      t.string    :mode_of_payment
      t.integer   :law_firm_id
      t.string    :bmo_lawyer_name
      t.integer   :lawyer_id
      t.string    :budget_amount
      t.integer   :lob_id
      t.string    :lob_contact_for_po
      t.string    :cost_centre_for_legal_fees
      t.string    :paying_entity
      t.string    :business_paying_for_matter
      t.string    :group_paying_for_matter
      t.string    :status
      t.datetime  :lob_submitted_at

      t.timestamps
    end
  end
end
