class AddColumnsToSecurityThreat < ActiveRecord::Migration[5.0]
  def change
    add_column :security_threats, :vendor, :text
    add_column :security_threats, :platform, :text
    add_column :security_threats, :version, :text
    add_column :security_threats, :service_pack, :text
  end
end
