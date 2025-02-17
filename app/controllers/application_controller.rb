class ApplicationController < ActionController::API
    include AccessControlHelper

    before_action :authorize_action

    def authorize_action
      controller = controller_name
      action = action_name
      role = current_user_role

      return if permission_granted?(role, controller, action)

      render json: { error: "Access Denied" }, status: :forbidden
    end

    private

    def current_user
      return @current_user if @current_user

      header = request.headers["Authorization"]
      header = header.split.last if header
      begin
        @decoded = JsonWebToken.decode(header)
        @current_user = User.find(@decoded["user_id"])
      rescue ActiveRecord::RecordNotFound => e
        render json: { errors: e.message }, status: :unauthorized
      end
    end

    def current_user_role
      if current_user.role == "admin"
        :full_admin
      else
        :normal
      end
    end

    def permission_granted?(role, controller, action)
      permissions = access_permissions[role.to_sym]
      return false unless permissions

      allowed_actions = permissions[controller.to_sym]
      allowed_actions&.include?(action)
    end
end
