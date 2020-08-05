class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.integer :point
      t.references :team, foreign_key: true
      t.references :championship, foreign_key: true

      t.timestamps
    end
  end
end
