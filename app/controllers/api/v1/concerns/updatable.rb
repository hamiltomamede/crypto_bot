module Api
  module V1
    module Concerns
      module Updatable
        extend ActiveSupport::Concern

        included do
          before_action :set_resource_updatable, only: :update
        end

        def update
          if @resource.update(resource_params)
            render json: @resource, status: :ok
          else
            render json: { errors: @resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def set_resource_updatable
          @resource = resource_class.find(params[:id])
        rescue ActiveRecord::RecordNotFound
          render json: { errors: "#{resource_class} not found" }, status: :not_found
        end

        def resource_params
          params.require(controller_name.singularize.to_sym).permit(*permitted_attributes)
        end

        def permitted_attributes
          raise NotImplementedError,
                'You must implement permitted_attributes in the including class.'
        end

        def resource_class
          controller_name.classify.constantize
        end
      end
    end
  end
end
