class Api::V1::OrdersController < ApplicationController
    before_action :authenticate

    def index
        query = get_query(params)
        @orders = Order.where(query).order(params[:sort] + ' ' + params[:order]).page(params[:page])
        render formats: :json
    end

    def show
        render json: Order.find(params[:id]), status: 200
    end

    def create
        address = Address.create(address_params)
        order = Order.new(code: params[:code],
                          address: address,
                          distance_from_src: Google::DistanceAPI.get_distance_matrix(@current_user.organization.warehouses.first.address.address, address.address),
                          organization_id: @current_user.id)
        if (address.id && order.save)
            render json: order, status: :created
        else
            render json: !address.errors.empty? && address.errors || order.errors, status: :unprocessable_entity
        end
    end

    def get_shortest_path
        render json: Route::Tsp.new.get_shortest_path(@current_user.organization.warehouses.first.address.address, Order.all), status: 200
    end

    def update
        address = Address.create(address_params)
        order = Order.find(params[:id])
        order.update(order_update_params)
        order.update(address: address)
    end

    def djisktra
        dim = 2
        infinity = 999
        matrix = Array.new(dim) { Array.new(dim) }
        v = Array.new(dim)
        pi = Array.new(dim)

        matrix[0][0] = infinity
        matrix[0][1] = 2
        matrix[1][0] = 3
        matrix[1][1] = infinity

        (0..dim-1).each do |i|
            v[i] = infinity
            pi[i] = -1
          (0..dim-1).each do |j|
            print "#{matrix[i][j]} \t"
          end
          print "\n"
        end

        render json: matrix, status: 200
    end

    def destroy
        if current_user.role == "organization"
            order = Order.find(params[:id])
            if(order.organization_id == current_user.id)
                order.delete
                render json: "order deleted succefully", status: 200
            end
        else
            render json: "error deleting order", status: 400
        end
    end

    private
    def address_params
        params[:address].require([:street, :number, :complement, :block, :city])
        params[:address].permit(:street, :number, :block, :city, :state, :zip, :latitude, :longitude, :country)
    end

    def order_update_params
        params[:order].permit(:code)
    end

    def get_query(params)
        if !params[:date].nil?
            date = DateTime.parse(params[:date])
            "created_at >= '#{date}' AND created_at <  '#{date+1}'"
        end
    end
end
