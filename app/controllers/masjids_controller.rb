class MasjidsController < ApplicationController

  # POST /masjids
  def create
    masjid = Masjid.new(masjid_params)

    # audit fields from logged-in user
    masjid.created_by = current_user.id
    masjid.updated_by = current_user.id

    if masjid.save
      render json: {
        message: "Masjid created successfully",
        masjid: masjid
      }, status: :created
    else
      render json: {
        errors: masjid.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # GET /masjids/:id
  def show
    masjid = Masjid.find(params[:id])

    render json: {
      masjid: masjid
    }, status: :ok

  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Masjid not found"
    }, status: :not_found
  end

  private

  def masjid_params
    params.permit(:name, :address, :imam_id)
  end
end