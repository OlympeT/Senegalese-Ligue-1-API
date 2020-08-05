Rails.application.routes.draw do
  namespace :api do
    get 'api_v1/teams'
    get 'api_v1/calendar'
    get 'api_v1/team'
    get 'api_v1/ranking'
  end
  get 'page/index'
  get 'page/resultat'
  get 'page/classement'
  mount RailsAdmin::Engine => '/admin-foot', as: 'rails_admin'

  devise_for :users,
             path: 'auth',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               password: 'secret'
             },
             controllers: {
               sessions: 'users/sessions'
             }
  devise_for :admins,
             controllers: {
               sessions: 'admins/sessions'
             }

  resources :games
  resources :championships
  resources :teams
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'page#index'

  # generate calendar
  get 'generer-calendrier' => 'games#generate_calendar', as: 'generate_calendar'
  # generate calendar
  get 'classement' => 'page#classement', as: 'classement'

  # API
  namespace :api do
    get '/v1/teams' => 'api_v1#teams'
    get '/v1/calendar' => 'api_v1#calendar'
    get '/v1/team/:id' => 'api_v1#team'
    get '/v1/ranking' => 'api_v1#ranking'
  end
end
