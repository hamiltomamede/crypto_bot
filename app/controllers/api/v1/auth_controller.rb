module Api
  module V1
    # Auth controller that authenticates the users
    class AuthController < ApplicationController
      before_action :authorize_action, except: %i[login logout]
      # rubocop:disable Metrics/AbcSize
      def login
        @user = User.find_by(email: params[:email])

        if @user&.authenticate(params[:password])
          token = JsonWebToken.encode(user_id: @user.id)

          render json: { token:, exp: 24.hours.from_now.to_i,
                         id: @user.id, name: @user.name, email: @user.email,
                         role: @user.role },
                 status: :ok
        else
          render json: { error: 'Invalid email or password' }, status: :unauthorized
        end
      end

      def logout
        render json: { success: 'Session ended' }, status: :ok
      end
    end
  end
end
# rubocop:enable Metrics/AbcSize
