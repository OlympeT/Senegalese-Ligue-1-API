class Api::ApiV1Controller < ApplicationController
  skip_before_action :verify_authenticity_token
  def teams
    @teams = Team.all
    render json: @teams
  end

  def calendar
    @games = Championship.last.games.order('date asc')
    response = []
    @games.each do |game|
      item = {
        home: game.home_team.name,
        home_score: game.home_score,
        home_logo: game.home_team.logo.thumb.url,
        away: game.away_team.name,
        away_score: game.away_score,
        away_logo: game.away_team.logo.thumb.url,
        date: game.date
      }
      response << item
    end
    render json: response
  end

  def team
    @team = Team.find(params[:id])
    render json: @team
  end

  def ranking
    @points = Championship.last.points.order('point DESC')
    response = []
    @points.each do |point|
      item = {
        name: point.team.name,
        logo: point.team.logo.thumb.url,
        point: point.point
      }
      response << item
    end
    render json: response
  end
end
