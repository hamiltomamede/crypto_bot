module Api
  module V1
class BotsController < ApplicationController
   # include filters - [where] [where_not] [contains]
   include Api::V1::Concerns::Filterable

   # GET /api/v1/users
   # GET /api/v1/users/:id
   include Api::V1::Concerns::Readable

   # POST /api/v1/users
   include Api::V1::Concerns::Creatable

   # PUT /api/v1/users/:id
   include Api::V1::Concerns::Updatable

   # DELETE /api/v1/users/:id
   include Api::V1::Concerns::Destroyable

  private

      def permitted_attributes
        %i[symbol minimum_balance maximum_trade_size strategy]
      end
end
  end
end
