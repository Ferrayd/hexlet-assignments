# frozen_string_literal: true

Rails.application.routes.draw do
  # BEGIN
  scope '(:locale)', locale: /en|ru/ do
    root 'home#index'

    resources :posts do
      scope module: :posts do
        resources :comments, only: %i[create destroy edit update]
      end
    end
  end
  # END

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
