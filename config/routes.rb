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

  get 'profile', to: 'profile#show'

  resources :feeds, only: %i[index]
  resources :follow_invitations, only: %i[index update]
  resources :followers, only: %i[index]
  resources :followings, only: %i[index]

  namespace :posts do
    resources :users, only: %i[create edit update destroy] do
      scope module: :users do
        resources :likes, only: %i[create destroy]
        resources :comments, only: %i[index edit create update destroy]
      end
    end
  end
end
