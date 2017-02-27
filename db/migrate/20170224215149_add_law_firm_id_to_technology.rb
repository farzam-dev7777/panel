class AddLawFirmIdToTechnology < ActiveRecord::Migration[5.0]
  def change
    add_column :technologies, :law_firm_id, :integer
    add_column :technologies, :submission_id, :integer
  end
end
