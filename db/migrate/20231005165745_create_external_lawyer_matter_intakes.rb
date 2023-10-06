class CreateExternalLawyerMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    create_table :external_lawyer_matter_intakes do |t|
      t.integer :external_lawyer_id
      t.integer :matter_intake_id
      t.timestamps
    end
  end
end
