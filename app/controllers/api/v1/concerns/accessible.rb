module Api
  module V1
    module Concerns
      # manages what actions is allowed for the current user
      module Accessible
        extend ActiveSupport::Concern

        included do
          before_action :authorize_access, only: %i[index create update destroy]
        end

        private

        def authorize_access
          case action_name
          when "index"
            authorize_index
          when "create", "update", "destroy"
            authorize_admin_actions
          else
            head :forbidden
          end
        end

        def authorize_index
          if current_user.role == "admin"
            resource_class.all
          else
            "not allowed"
          end
        end

        def authorize_show(resource)
          return if current_user&.admin?

          if resource.is_a?(Circuit)
            if resource.id != current_user.circuit_id
              render json: { error: "Access denied" }, status: :forbidden
            end
          elsif current_user.present?
            if resource.circuit_id != current_user.circuit_id
              render json: { error: "Access denied" }, status: :forbidden
            end
          else
            render json: { error: "Unauthorized" }, status: :unauthorized
          end
        end

        def authorize_admin_actions
          return if current_user&.admin?

          render json: { error: "Access denied" }, status: :forbidden
        end
      end
    end
  end
end
