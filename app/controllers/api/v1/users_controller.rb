class Api::V1::UsersController < ApplicationController
  skip_before_action :authenticate, only: [:login, :create]

  def index
    render formats: :json
  end

  def show
    # the organization user is fetching self data
    if( @current_user.id == params[:id].to_i)
      @user = User.find_by(organization: @current_user.id, id: params[:id])
    else
      #possibility: . retrieve user and then check if organization_id = params[:id]
      #             . create a separated controller
      begin
        @user = @current_user.organization.drivers.find_by(user_id: params[:id]).user
      rescue ActiveRecord::RecordNotFound
        return render json: 'wrong parameters', status: 400
      end
    end

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