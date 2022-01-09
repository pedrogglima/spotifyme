# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             class_name: 'User',
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  devise_scope :user do
    root to: 'users/sessions#show'
  end

  get 'profile', to: 'home#profile'
  get 'settings', to: 'home#settings'

  resources :settings, only: %i[update]
  resources :feeds, only: %i[index]
  resources :follow_invitations, only: %i[index create update]
  resources :followers, only: %i[index]
  resources :followings, only: %i[index]
  resources :likes, only: %i[create destroy]

  scope :posts do
    resources :comments, only: %i[index edit create update destroy]
  end

  namespace :posts do
    resources :users, only: %i[create edit update destroy]
  end
end
