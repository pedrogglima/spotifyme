# frozen_string_literal: true

Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users,
             class_name: 'User',
             controllers: {
               sessions: 'users/sessions',
               omniauth_callbacks: 'users/omniauth_callbacks'
             }

  devise_scope :user do
    root to: 'users/sessions#show'
  end

  get 'feed',          to: 'home#feed'
  get 'profile',       to: 'home#profile'
  get 'settings',      to: 'home#settings'
  get 'search',        to: 'home#search'

  resources :follow_invitations, only: %i[index create update]
  resources :followers, only: %i[index]
  resources :followings, only: %i[index]
  resources :likes, only: %i[create destroy]
  resources :notifications, only: %i[index]
  resources :settings, only: %i[update]

  resources :users, only: %i[index]

  scope :posts do
    resources :comments, only: %i[index edit create update destroy]
  end

  namespace :posts do
    # resources :albums, only: %i[index]
    resources :tracks, only: %i[destroy]
    resources :users, only: %i[index create edit update destroy]
  end

  case Rails.configuration.upload_server
  when :s3
    # By default in production we use s3, including upload directly to S3 with
    # signed url.
    mount Shrine.presign_endpoint(:cache) => '/s3/params'
  when :s3_multipart
    # Still upload directly to S3, but using Uppy's AwsS3Multipart plugin
    mount Shrine.uppy_s3_multipart(:cache) => '/s3/multipart'
  when :app
    # In development and test environment by default we're using filesystem storage
    # for speed, so on the client side we'll upload files to our app.
    mount Shrine.upload_endpoint(:cache) => '/upload'
  end

  mount AlbumUploader.derivation_endpoint => '/derivations/album'
  mount AvatarUploader.derivation_endpoint => '/derivations/avatar'
  mount TrackUploader.derivation_endpoint => '/derivations/track'
end
