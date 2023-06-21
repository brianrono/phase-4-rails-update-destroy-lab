class PlantsController < ApplicationController
  # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = Plant.find_by(id: params[:id])
    if plant
      render json: plant
    else
      render json: { error: "Plant not found" }, status: :not_found
    end
  end

  # PATCH /plants/:id
  def update
    plant = Plant.find_by(id: params[:id])
    if plant
      if plant.update(plant_params)
        render json: plant
      else
        render json: { error: "Failed to update plant" }, status: :unprocessable_entity
      end
    else
      render json: { error: "Plant not found" }, status: :not_found
    end
  end

  # DELETE /plants/:id
  def destroy
    plant = Plant.find_by(id: params[:id])
    if plant
      plant.destroy
      render json: { message: "Plant deleted successfully" }
    else
      render json: { error: "Plant not found" }, status: :not_found
    end
  end

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    if plant.valid?
      render json: plant, status: :created
    else
      render json: { error: plant.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def plant_params
    params.permit(:name, :image, :price, :is_in_stock)
  end
end
