class AddColRetainerCoverToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :retainer_cover, :text
  end
end
