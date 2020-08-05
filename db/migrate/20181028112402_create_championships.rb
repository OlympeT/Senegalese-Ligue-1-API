class CreateChampionships < ActiveRecord::Migration[5.2]
  def change
    create_table :championships do |t|
      t.date :beginning
      t.date :end

      t.timestamps
    end
  end
end
