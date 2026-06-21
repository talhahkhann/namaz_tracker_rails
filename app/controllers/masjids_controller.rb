class MasjidsController < ApplicationController
  before_action :set_masjid, only: [:show, :update, :destroy]

  # POST /createmasjid
  def create
    masjid = Masjid.new(masjid_params)

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

  # GET /getallmasjids
  def index
    masjids = Masjid.all

    render json: {
      count: masjids.count,
      masjids: masjids
    }, status: :ok
  end

  # GET /getmasjidbyid/:id
  def show
    render json: {
      masjid: @masjid
    }, status: :ok
  end

  # PUT/PATCH /updatemasjid/:id
  def update
    if @masjid.update(masjid_params.merge(updated_by: current_user.id))
      render json: {
        message: "Masjid updated successfully",
        masjid: @masjid
      }, status: :ok
    else
      render json: {
        errors: @masjid.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  # DELETE /deletemasjid/:id
  def destroy
    @masjid.destroy

    render json: {
      message: "Masjid deleted successfully"
    }, status: :ok
  end

  private

  def set_masjid
    @masjid = Masjid.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: {
      error: "Masjid not found"
    }, status: :not_found
  end

  def masjid_params
    params.permit(
      :name,
      :address,
      :imam_id
    )
  end
end