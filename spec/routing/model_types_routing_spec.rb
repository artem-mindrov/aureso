require 'rails_helper'

describe V1::ModelTypesController, type: :routing do
  it { expect(get: "/models/model-slug/model_types").to route_to("v1/model_types#index",
                                                                     model_id: "model-slug", format: "json") }
  it { expect(post: "/models/model-slug/model_types_price/model-type-slug").to(
      route_to("v1/model_types#model_types_price",
               format: "json", model_id: "model-slug", model_type_id: "model-type-slug")) }
  it { expect(get: "/non-existent-route").to route_to("errors#routing_error", path: "non-existent-route") }
end