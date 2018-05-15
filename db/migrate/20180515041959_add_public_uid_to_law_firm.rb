class AddPublicUidToLawFirm < ActiveRecord::Migration[5.0]
  def change
    add_column :law_firms, :public_uid, :string
  end
end
