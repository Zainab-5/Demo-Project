Rails.application.routes.draw do
  devise_for :users
  resources :plans, except: [:show]
  resources :subscriptions, except: [:destroy, :update]
  resources :features, except: [:show]
  resources :usages, except: [:destroy, :update]
  get 'billing/:id' => 'bill#billing', as: :billing
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
