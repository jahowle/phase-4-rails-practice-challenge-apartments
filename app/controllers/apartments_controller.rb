class ApartmentsController < ApplicationController
    def index
        apartments = apartment.all 
        render json: apartments
        end
    
        def show
        apartment = Apartment.find_by(id: params[:id])
            if apartment
                render json: apartment
            else
                render json: { error: "apartment not found" }, status: :not_found
            end
        end
    
        def create
        apartment = Apartment.create!(apartment_params)
        render json: apartment, status: :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
        end
    
        def update
            apartment = Apartment.find_by(id: params[:id])
            if apartment
                apartment.update(apartment_params)
                render json: apartment
            else
                render json: { error: "apartment not found" }, status: :not_found
            end
    
        end
    
        def destroy
            apartment = Apartment.find_by(id: params[:id])
            if apartment
                apartment.destroy
                head :no_content
            else
                render json: { error: "apartment not found" }, status: :not_found
            end
    
        end
    
        private
    
        def apartment_params
            params.permit(:number)
        end
end
