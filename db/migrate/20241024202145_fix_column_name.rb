class FixColumnName < ActiveRecord::Migration[7.2]
  def change
    rename_column :packages, :type, :name
  end
end
