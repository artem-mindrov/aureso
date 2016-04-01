json.models(@models) do |model|
  json.name model.name
  json.model_types(model.model_types) do |type|
    json.name type.name
    json.total_price type.total_price
  end
end