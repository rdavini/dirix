class Api::V1::OrdersController < ApplicationController
    before_action :authenticate

    def index
        @orders = Order.all
        render formats: :json
    end

    def create
        order = Order.new(order_params)
        order.organization = @current_user.organization

        if (order.save)
            render json: order, status: :created
        else
            render json: order.errors, status: :unprocessable_entity
        end
    end

    private
    def order_params
        params.permit(:code, :street, :number, :block, :city, :state, :zip, :organization_id)
    end
end
