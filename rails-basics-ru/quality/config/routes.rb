# frozen_string_literal: true

Rails.application.routes.draw do
  root 'bulletins#index'
  # get 'bulletins', to: 'bulletins#index'
  # get 'bulletins/show'
  resources :bulletins, only: %i[index show]
end
