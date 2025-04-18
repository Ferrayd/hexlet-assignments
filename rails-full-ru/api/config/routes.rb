# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    resources :users
  end

  # BEGIN
  Rails.application.routes.draw do
    namespace :api do
      resources :users, only: [:index, :show]
    end
  end  
  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
