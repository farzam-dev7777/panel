class AddColAdditionalCommentsForLrcLawyerToMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    add_column :matter_intakes, :additional_comments_for_lrc_lawyer, :string
  end
end
