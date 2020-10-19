Rails.application.routes.draw do

  get 'usages/index'
  root to: 'welcome#index'
  devise_for :users
  resources :plans
  resources :subscriptions
  resources :plans
  resources :features
  resources :usages
  get 'welcome/index'

end
