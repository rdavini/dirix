class Api::V1::WarehousesController < ApplicationController
    def index
        render format: :json
    end

    def create
        # Warehouse.create()
        binding.pry
    end

    # private
    # def warehouse_parameters
    #     params.permit(:name, :)
    # end
end
