class Api::V1::ModelTypesController < ApplicationController
  # why oh why do I need the model slug in route params ?
  def index
    @models = Model.includes(:model_types)
  end
end
