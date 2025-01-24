module Api
  module V1
    module Concerns
      module ImportableFromExcel
        extend ActiveSupport::Concern

        included do
          before_action :validate_file_presence, only: :import_from_excel
          class_attribute :import_attributes
          class_attribute :unique_attributes
        end

        class_methods do
          def set_import_attributes(attributes, unique_by:)
            self.import_attributes = attributes
            self.unique_attributes = unique_by
          end
        end

        def import_from_excel
          file = params[:file]
          errors = []
          # Retreive the extension of the file
          file_ext = File.extname(file.original_filename)
          raise "Unknown file type: #{file.original_filename}" unless ['.xls',
                                                                       '.xlsx'].include?(file_ext)

          spreadsheet = file_ext == '.xls' ? Roo::Excel.new(file.path) : Roo::Excelx.new(file.path)
          header = spreadsheet.row(1)
          import_attributes = self.class.import_attributes

          (2..spreadsheet.last_row).each do |i|
            attributes = {}
            import_attributes.each_with_index do |attr, index|
              attributes[attr] = spreadsheet.row(i)[index]
            end

            unique_conditions = unique_attributes.map { |attr| [attr, attributes[attr]] }.to_h
            existing_resource = resource_class.find_by(unique_conditions)
            if existing_resource.present?
              errors << "Row #{i}: #{resource_class} '#{spreadsheet.row(i)[0]}' already created!"
            else
              resource = resource_class.new(attributes)
              unless resource.save
                errors << "Row #{i}: #{resource.class.name} - #{resource.errors.full_messages.join(', ')}"
              end
            end
            next
          end

          if errors.count == spreadsheet.last_row - 1
            render json: { status: 'ERROR', message: "Falha na importação, #{errors}" },
                   status: :unprocessable_entity
          else
            render json: { status: 'SUCCESS', message: 'Importação finalizada!' }, status: :ok
          end
        end

        private

        def model_class
          controller_name.classify.constantize
        end

        def validate_file_presence
          return unless params[:file].blank?

          render json: { status: 'ERROR', message: 'No file attached' }, status: :bad_request
        end
      end
    end
  end
end
