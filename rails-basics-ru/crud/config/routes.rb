# frozen_string_literal: true

Rails.application.routes.draw do
  resources :tasks
  root 'home#index'
  # BEGIN
  # END
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
