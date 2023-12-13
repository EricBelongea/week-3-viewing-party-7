Rails.application.routes.draw do
  root 'welcome#index'

  get '/register', to: 'users#new'
  post '/users', to: 'users#create'

  # get "/users/:id", to: "users#show", as: "dashboard"

  get "/login", to: "users#login_form"
  post "/login", to: "users#login_user"
  get "/log_out", to: "users#log_out"

  get '/users/:id/movies', to: 'movies#index', as: 'movies'
  get '/users/:user_id/movies/:id', to: 'movies#show', as: 'movie'

  # resources :users, only: :show
  get "/dashboard", to: "users#show"

  get '/users/:user_id/movies/:movie_id/viewing_parties/new', to: 'viewing_parties#new'
  post '/users/:user_id/movies/:movie_id/viewing_parties', to: 'viewing_parties#create'
end
