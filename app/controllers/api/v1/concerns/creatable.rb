module Api
  module V1
    module Concerns
      module Creatable
        extend ActiveSupport::Concern

        included do
          before_action :set_resource_creatable
        end

        def create
          @resource = resource_class.new(resource_params)

          if @resource.save
            render json: @resource, status: :created
          else
            render json: { errors: @resource.errors.full_messages }, status: :unprocessable_entity
          end
        end

        private

        def resource_params
          params.require(controller_name.singularize.to_sym).permit(*permitted_attributes)
        end

        def set_resource_creatable
          @resource_class = resource_class
        end

        def resource_class
          controller_name.classify.constantize
        end
      end
    end
  end
end
