module Api
  module V1
    module Concerns
      # A soft delete for the Resources
      module Destroyable
        extend ActiveSupport::Concern

        included do
          before_action :set_resource_destroyable, only: :destroy
        end

        def destroy
          return unless @resource.deny

          @resource.save
          render json: { message: "#{@resource} deleted successfully." }, status: :ok
        end

        private

        def set_resource_destroyable
          @resource = resource_class.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: "#{resource_class} not found" }, status: :not_found
        end

        def resource_class
          controller_name.classify.constantize
        end
      end
    end
  end
end
