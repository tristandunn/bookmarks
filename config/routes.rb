# frozen_string_literal: true

Rails.application.routes.draw do
  get "/health", to: "health#index"

  resources :bookmarks, only: %i(new create)

  root "bookmarks#index"
end
