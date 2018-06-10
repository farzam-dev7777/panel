class AddFaqCategoryIdToFaqs < ActiveRecord::Migration[5.0]
  def change
    add_column :frequently_asked_questions, :faq_category_id, :integer
  end
end
