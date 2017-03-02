class AddSubmissionIdToNotes < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :submission_id, :integer
  end
end
