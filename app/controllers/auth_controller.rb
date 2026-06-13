class AuthController < ApplicationController
  # REGISTER
  def register
    user = User.new(user_params)

    if user.save
      token = JwtService.encode(user_id: user.id, role: user.role)

      render json: {
        message: "User created",
        token: token,
        user: user
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # LOGIN
  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JwtService.encode(user_id: user.id, role: user.role)

      render json: {
        message: "Login successful",
        token: token,
        user: user
      }
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation, :role)
  end
end