class ChangeGameColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :games, :date, :date
  end
end
