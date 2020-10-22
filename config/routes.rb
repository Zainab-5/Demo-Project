Rails.application.routes.draw do
  devise_for :users
  resources :plans
  resources :subscriptions
  resources :plans
  resources :features
  resources :usages
  get 'billing/:id' => 'bill#billing', as: :billing, via: :get
  devise_scope :user do
    root to: "devise/sessions#new"
  end

end
