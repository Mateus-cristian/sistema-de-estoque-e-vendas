# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root "home#index"
  get "landing", to: "landing#index", as: :landing
  get "home", to: "home#index", as: :home

  resources :products, path: "produtos", controller: "products", only: [:index, :new, :create, :update, :destroy, :edit, :show] do
    member do
      get :form_page
    end
  end

  resources :sales, path: "vendas", only: [:index, :new, :create, :show, :destroy]

  namespace :admin do
    get :dashboard, path: "painel", to: "dashboard#index"
    get :reports, path: "relatorios", to: "reports#index"
    get :stock_report, path: "relatorio-estoque", to: "stock_reports#index"
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
