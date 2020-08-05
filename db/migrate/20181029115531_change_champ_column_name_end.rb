class ChangeChampColumnNameEnd < ActiveRecord::Migration[5.2]
  def change
    rename_column :championships, :end, :end_saison
  end
end
