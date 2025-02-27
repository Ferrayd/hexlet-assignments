# frozen_string_literal: true

Rails.application.routes.draw do
  root 'homes#index'

  # BEGIN
  resources :posts do
    resources :comments, module: :posts, only: %i[create edit update destroy]
  end
  # END
end
