Rails.application.routes.draw do

  devise_for :users, skip: :all
  devise_scope :user do
    get '/users/sign_up', to: 'registrations#new', as: :new_user_registration
    post '/users', to: 'registrations#create', as: :user_registration
    get "/users/sign_in", to: "sessions#new", as: :new_user_session
    post "/users/sign_in", to: "sessions#create",as: :user_session
    delete "/users/sign_out", to: "sessions#destroy",as: :destroy_user_session
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#top"
  resource :users
  resources :wishes do
    resources :complete_reviews
  end

  get "dones" => "wishes#dones",as: :wishes_dones
  patch "wishes/:id/complete" => "wishes#complete", as: :wishes_complete
  resources :tags
  get "done_tags" => "tags#dones", as: :tags_dones
  patch "wishes/:id/backWish" => "wishes#backWish", as: :wishes_back
  get "wishes/:id/confirm" => "wishes#confirm", as: :wishes_confirm
end
