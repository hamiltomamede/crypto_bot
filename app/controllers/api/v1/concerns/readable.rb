module Api
  module V1
    module Concerns
      # To include associations send:
      # api/v1/model?include=association1:attribute1;attribute2,association2:attribute1;
      # api/v1/circuits?include=congregations:name
      module Readable
        extend ActiveSupport::Concern
        # include access controll concern
        include Api::V1::Concerns::Accessible

        included do
          before_action :set_resource_readable, only: :show
          before_action :set_collection, only: :index
        end

        def index
          render json: { data: @json, total: @json.size }, include: include_associations
        end

        def show
          render json: @resource, include: include_associations
        end

        private

        def set_collection
          scope = authorize_index
          @json = apply_filters(scope)
        end

        def set_resource_readable
          @resource = resource_class.find(params[:id])
          authorize_show(@resource)
        rescue ActiveRecord::RecordNotFound
          render json: { errors: "#{resource_class} not found" }, status: :not_found
        end

        def include_associations
          return {} unless params[:include]

          associations = params[:include].to_s.split(',')
          associations.each_with_object({}) do |include_param, hash|
            relation, fields = include_param.split(':', 2)
            hash[relation.to_sym] = fields ? { only: fields.split(';') } : {}
          end
        end

        def resource_class
          controller_name.classify.constantize
        end
      end
    end
  end
end
