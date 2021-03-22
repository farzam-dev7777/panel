class ChangeColsTypesInMatterIntakes < ActiveRecord::Migration[5.0]
  def up
    change_column :matter_intakes, :is_ore_reportable, :string, :using => "case when is_ore_reportable then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :is_otherwise_reportable, :string, :using => "case when is_otherwise_reportable then 'Yes' else 'No' end", default: nil
    change_column :matter_intakes, :is_alternative_fee_arrangement, :string, :using => "case when is_alternative_fee_arrangement then 'Yes' else 'No' end", default: nil
  end

  def down
    change_column :matter_intakes, :is_ore_reportable, 'boolean USING CAST(is_ore_reportable AS boolean)', default: nil
    change_column :matter_intakes, :is_otherwise_reportable, 'boolean USING CAST(is_otherwise_reportable AS boolean)', default: nil
    change_column :matter_intakes, :is_alternative_fee_arrangement, 'boolean USING CAST(is_alternative_fee_arrangement AS boolean)', default: nil
  end
end
