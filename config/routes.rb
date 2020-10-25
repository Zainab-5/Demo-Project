# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :plans, except: [:show]
  resources :subscriptions, except: %i[destroy update]
  resources :features, except: [:show]
  resources :usages, except: %i[destroy update]
  get 'billing/:id' => 'bill#billing', as: :billing
  devise_scope :user do
    root to: 'devise/sessions#new'
  end
end
