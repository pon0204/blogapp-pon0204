class RenameNicklnameColumnToProfiles < ActiveRecord::Migration[6.0]
  def change
    rename_column :profiles, :nicklname, :nickname
  end
end
