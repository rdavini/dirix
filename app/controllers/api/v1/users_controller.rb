class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]

  def index
    render formats: :json
  end

  def show
    render json: @user
  end

  def create
    if params[:role] != "organization"
      authenticate
      return if 401 == status
      params[:organization_id] = @current_user.organization.id
    end

    @user = User.create(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def login 
    user = User.find_by(email: params[:email])
    if user and user.valid_password?(params[:password])
      user.driver.working_days.find_or_create_by(date: Date.today) if user.role == "driver"
      p "user token:"
      p user
      p user.api_key.token
      render json:{ token: user.api_key.token }
    else
      render json: { errors: "User or Password are invalid!" }, status: :unauthorized
    end
  end

  def info
    render formats: :json
  end

  private
    def user_params
      params.permit(:password, :email, :phone, :role, :license_plate, :vehicle_brand, :vehicle_color, :organization_id)
    end
end