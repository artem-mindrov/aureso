class V1::ModelTypesController < ApplicationController
  # why oh why do I need the model slug in route params ?
  def index
    @models = Model.includes(:model_types)
  end

  def model_types_price
    @model_type = Model.find(model_type_params[:model_id]).model_types.find(model_type_params[:model_type_id])
  end

  private

  def model_type_params
    params.permit(:model_id, :model_type_id)
  end
end
