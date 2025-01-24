module Api
  module V1
    # definitions to user controller
    class UsersController < ApplicationController
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
        %i[email name password password_confirmation circuit_id congregation_id
           circuit_admin full_admin]
      end
    end
  end
end
