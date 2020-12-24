class AddLawFirmIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :law_firm_id, :string
  end
end
