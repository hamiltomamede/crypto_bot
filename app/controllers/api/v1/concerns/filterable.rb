module Api
  module V1
    module Concerns
      # Its possible to use 3 types of filters :
      # where, where_not, contains
      # api/v1/model?query?[where][attribute1]='value'
      # api/v1/circuits?query[where][name]='test'
      module Filterable
        extend ActiveSupport::Concern

        private

        def apply_filters(scope)
          if params[:query]

            scope = filter_where(scope, params.dig(:query, :where)) if params.dig(:query, :where)

            scope = filter_where_not(scope, params.dig(:query, :where_not)) if params.dig(
              :query, :where_not
            )
            scope = filter_contains(scope, params.dig(:query, :contains)) if params.dig(
              :query, :contains
            )
          else
            scope
          end
          scope
        end

        def filter_where(scope, conditions)
          conditions.each do |field, value|
            scope = scope.where(field => value)
          end
          scope
        end

        def filter_where_not(scope, conditions)
          conditions.each do |field, value|
            scope = scope.where.not(field => value)
          end
          scope
        end

        def filter_contains(scope, conditions)
          conditions.each do |field, value|
            scope = scope.where("#{field} LIKE ?", "%#{value}%")
          end
          scope
        end

        def resource_class
          controller_name.classify.constantize
        end
      end
    end
  end
end
