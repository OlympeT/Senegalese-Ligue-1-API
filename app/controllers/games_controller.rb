class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /games
  # GET /games.json
  def index
    @games = Game.order(date: :asc)
  end

  # GET /games/1
  # GET /games/1.json
  def show;  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit;  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        # distribute the points to the team
        @game.played = true
        @game.save
        if @game.home_score > @game.away_score
          point = Point.find_by(:championship_id => Championship.last.id, :team_id => @game.home_team_id)
          point.point += 3
        elsif @game.home_score < @game.away_score
          point = Point.find_by(:championship_id => Championship.last.id, :team_id => @game.away_team_id)
          point.point += 3
        else
          point = Point.find_by(:championship_id => Championship.last.id, :team_id => @game.home_team_id)
          point.point += 1
          point.save
          point = Point.find_by(:championship_id => Championship.last.id, :team_id => @game.away_team_id)
          point.point += 1
        end
        point.save
        format.html { redirect_to games_path, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to games_url, notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Generate calendar
  def generate_calendar
    # Check if user create 1 championship
    if !Championship.last
      flash[:error] = "Vous devez créer 1 championnat. Merci de <a href='#{championships_path}'>Cliquer ici.</a>"
      redirect_to games_path
    # Check if user create 10 teams
    elsif Team.all.size != 10
      flash[:error] = "Vous devez créer 10 équipes. Merci de <a href='#{teams_path}'>Cliquer ici.</a>"
      redirect_to games_path
    # Check if games already generated for the last championship
    elsif !Game.where(:date => Championship.last.beginning..Championship.last.end_saison).empty?
      flash[:error] = 'Dernier Champinnat deja généré.'
      redirect_to games_path
    # generate championship calendar
    else
      # championship date range
      range_date = (Championship.last.beginning...Championship.last.end_saison).to_a
      teams = Team.all
      adver = teams
      # for each team take date and opponent
      teams.each do |team|
        Point.create(point: 0, team_id: team.id, championship_id: Championship.last.id)
        adver.each do |ads|
          next unless team.id != ads.id
          date = range_date.sample
          while Game.find_by(:home_team_id => team.id, :date => date) || Game.find_by(:away_team_id => team.id, :date => date) ||  Game.find_by(:away_team_id => ads.id, :date => date) || Game.find_by(:home_team_id => ads.id, :date => date)
            date = range_date.sample
            puts 'OK'
          end
          Game.create(home_team_id: team.id, away_team_id: ads.id, date: date, championship_id: Championship.last.id)
        end
      end
      flash[:success] = 'Champinnat  généré.'
      redirect_to games_path
    end


  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def game_params
    params.require(:game).permit(:home_team_id, :home_score, :away_team_id, :away_score, :played, :date, :championship_id)
  end
end
