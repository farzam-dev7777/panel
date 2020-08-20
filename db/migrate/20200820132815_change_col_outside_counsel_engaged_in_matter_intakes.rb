class ChangeColOutsideCounselEngagedInMatterIntakes < ActiveRecord::Migration[5.0]
  def change
    def up
      change_column :matter_intakes, :outside_counsel_engaged, :string, :using => "case when outside_counsel_engaged then 'Yes' else 'No' end", default: nil
    end
  
    def down
      change_column :matter_intakes, :outside_counsel_engaged, 'boolean USING CAST(outside_counsel_engaged AS boolean)', default: nil
    end
  end
end
