class Api::V1::CompaniesController < ApplicationController
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
        %i[name address email]
      end
end
