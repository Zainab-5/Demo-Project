Rails.application.routes.draw do
  root to: 'welcome#index'
  devise_for :users
  resources :users do
    resources :plans
  end

  get 'welcome/index'
end
