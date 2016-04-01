require 'rails_helper'

describe Api::V1::ModelTypesController, type: :routing do
  it { expect(get: "/api/models/model-slug/model_types").to route_to("api/v1/model_types#index",
                                                                     model_id: "model-slug", format: "json") }
end