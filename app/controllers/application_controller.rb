class ApplicationController < ActionController::API
  before_action :authorize_request

  attr_reader :current_user

  private

  def authorize_request
    header = request.headers['Authorization']

    return render json: { error: "Missing token" }, status: :unauthorized if header.blank?

    token = header.split(' ').last

    decoded = JwtService.decode(token)

    return render json: { error: "Invalid token" }, status: :unauthorized if decoded.nil?

    @current_user = User.find(decoded["user_id"])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User not found" }, status: :unauthorized
  end
end