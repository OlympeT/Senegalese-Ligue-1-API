class PageController < ApplicationController
  def index
    @page = 'calendrier'
    champ = Championship.last
    if champ
      @jour_match = champ.games.order('date asc').map(&:date).uniq
    end
  end

  def resultat; end

  def classement
    @page = 'classement'
    champ = Championship.last
    if champ
      @points = champ.points.order('point DESC')
    end
  end
end
