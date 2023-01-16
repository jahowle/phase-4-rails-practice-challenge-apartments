class LeasesController < ApplicationController
    
        def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :created
        rescue ActiveRecord::RecordInvalid => e
            render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
        end
    
       
        def destroy
            lease = Lease.find_by(id: params[:id])
            if lease
                lease.destroy
                head :no_content
            else
                render json: { error: "lease not found" }, status: :not_found
            end
    
        end
    
        private
    
        def lease_params
            params.permit(:name, :major, :instructor_id, :age)
        end
end
