class Api::UsersController < ApplicationController
    include ApiModule

    def index
        @users = User.all
        render json: @users, status: :ok
    end

    def show
        username = params[:username]
        if (User.where(username: username).exists?)
           result = get_user(username)
        else
           result = create_user(username)
        end

        if (result[:is_success])
            render json: result[:data], status: :ok
        else
            render json: result[:data], status: :not_found
        end
    end
end