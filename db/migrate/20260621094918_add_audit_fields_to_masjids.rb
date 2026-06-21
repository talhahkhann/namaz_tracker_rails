class AddAuditFieldsToMasjids < ActiveRecord::Migration[8.1]
  def change
    add_column :masjids, :created_by, :integer
    add_column :masjids, :updated_by, :integer
  end
end
