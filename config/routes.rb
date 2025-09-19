# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "pages#home", via: [:get, :post]

  resources :products, only: [:index, :new, :create, :update, :destroy] do
    member do
      get :form_page
    end
  end

  resources :sales, only: [:index, :new, :create, :show, :destroy]

  namespace :admin do
    get "dashboard", to: "dashboard#index", as: :dashboard
    get "reports", to: "reports#index", as: :reports
  end


  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
