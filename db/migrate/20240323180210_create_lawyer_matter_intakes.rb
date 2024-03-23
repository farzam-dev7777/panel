class CreateLawyerMatterIntakes < ActiveRecord::Migration[7.0]
  def change
    create_table :lawyer_matter_intakes do |t|
      t.integer :user_id
      t.integer :matter_intake_id
      t.timestamps
    end
  end
end
