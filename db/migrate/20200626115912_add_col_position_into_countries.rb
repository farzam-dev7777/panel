class AddColPositionIntoCountries < ActiveRecord::Migration[5.0]
  def change
    add_column :countries, :position, :integer 
  end
end
