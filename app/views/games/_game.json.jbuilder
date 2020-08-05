json.extract! game, :id, :home_team_id, :home_score, :away_team_id, :away_score, :played, :date, :championship_id, :created_at, :updated_at
json.url game_url(game, format: :json)
