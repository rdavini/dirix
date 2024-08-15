module ApplicationCable
  class Channel < ActionCable::Channel::Base
    attr_reader :current_api_token, :current_user
    before_subscribe :authenticate

    def authenticate
          authenticate_user_with_token || handle_bad_authentication
    end

    private
    def authenticate_user_with_token
        @current_api_token = ApiKey.find_by(token: params[:token])
        return nil if @current_api_token.nil?

        @current_user = @current_api_token.user
    end

    def handle_bad_authentication
        render json: { message: "Bad credentials" }, status: :unauthorized
    end
  end
end
