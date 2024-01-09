class Api::V1::OrdersController < ApplicationController
    before_action :authenticate
    include Route
    def index
        @orders = Order.all
        render formats: :json
    end

    def create
        address = Address.find_or_create_by(address_params)

        order = Order.new(code: params[:code],
                          address: address,
                          distance_from_src: Google::DistanceAPI.get_distance_matrix(@current_user.organization.warehouses.first.address.address, address.address),
                          organization_id: @current_user.id)

        if (order.save)
            render json: order, status: :created
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    def get_shortest_path
        render json: Route::Tsp.new.get_shortest_path(@current_user.organization.warehouses.first.address.address, Order.all), status: 200
    end

    private
    def address_params
        params.permit(:street, :number, :block, :city, :state, :zip, :latitude, :longitude, :country)
    end
end
