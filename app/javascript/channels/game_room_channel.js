Rails.application.routes.draw do
  root "pages#home"
  resources :game_rooms, only: %i[new create show] do
    member do
      post :start_game
      post :next_hand
    end
    resources :players, only: %i[create]
    resources :action_records, only: %i[create]
  end
end
