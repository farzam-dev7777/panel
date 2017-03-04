class AddFollowUpIdToNote < ActiveRecord::Migration[5.0]
  def change
    add_column :notes, :follow_up_id, :integer
  end
end
