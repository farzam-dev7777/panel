class AddIdColToMissingIdTables < ActiveRecord::Migration[5.0]
  def change
    ["issues", "values", "feedbacks", "law_firms_matter_types", "law_firms_sub_matter_types", "law_firms_jurisdiction_types"].each do |table_name|
      begin
        ActiveRecord::Base.transaction do 
          execute "ALTER TABLE #{table_name} ADD COLUMN id SERIAL PRIMARY KEY;"
          execute "COMMIT;"
        end
        puts "added to #{table_name}"
      rescue => exception
        puts exception
      end
    end
  end
end
