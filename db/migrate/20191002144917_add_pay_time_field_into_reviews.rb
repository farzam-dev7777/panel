class AddPayTimeFieldIntoReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :pay_type, :string
  end
end
