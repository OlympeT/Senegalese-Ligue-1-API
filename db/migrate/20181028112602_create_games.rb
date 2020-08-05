class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :home_score
      t.integer :away_team_id
      t.integer :away_score
      t.boolean :played
      t.datetime :date
      t.references :championship, foreign_key: true

      t.timestamps
    end

    add_index :games, %i[home_team_id away_team_id]
  end
end
