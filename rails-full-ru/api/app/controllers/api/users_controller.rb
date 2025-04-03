# frozen_string_literal: true

# app/controllers/api/users_controller.rb
module Api
  class UsersController < ApplicationController
    respond_to :json

    def index
      @users = User.all
      respond_with @users
    end

    def show
      @user = User.find(params[:id])
      respond_with @user
    end
  end
end