class AddNotesFieldIntoExceptionRequest < ActiveRecord::Migration[5.0]
  def change
    add_column :exception_requests, :notes, :text
  end
end
