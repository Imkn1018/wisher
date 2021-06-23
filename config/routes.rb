Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  resource :users
  resources :wishes do
    resources :complete_reviews
  end
  get 'all' => 'wishes#all', as: :all
  get 'dones' => 'wishes#dones', as: :wishes_dones
  patch 'wishes/:id/complete' => 'wishes#complete', as: :wishes_complete
  resources :tags
  get 'done_tags' => 'tags#dones', as: :tags_dones
  patch 'wishes/:id/backWish' => 'wishes#backWish', as: :wishes_back
  get 'wishes/:id/confirm' => 'wishes#confirm', as: :wishes_confirm

  # ゲストログイン機能
  post '/homes/guest_sign_in', to: 'homes#guest_sign_in'

  get 'search' => 'wishes#search'
end
