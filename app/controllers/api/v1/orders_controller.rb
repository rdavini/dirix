class Api::V1::OrdersController < ApplicationController
    before_action :authenticate

    def index
        @orders = Order.all
        render formats: :json
    end

    def create
        address = Address.find_or_create_by(order_params)
        order = Order.new

        order.organization = @current_user.organization
        order.address = address

        if (order.save)
            render json: order, status: :created
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    private
    def order_params
        params.permit(:street, :number, :block, :city, :state, :zip)
    end
end
