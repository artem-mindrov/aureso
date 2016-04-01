require 'rails_helper'

# https://github.com/rails/jbuilder/issues/32#issuecomment-32216199
RSpec.describe Api::V1::ModelTypesController, type: :request do
  describe "GET #index" do
    it "returns the list of models and their types" do
      m = create(:model)
      create_list(:model_type, 10, model_id: m.id)
      ModelType.any_instance.stub(:total_price).and_return(200)

      get "/api/models/#{m.slug}/model_types"

      parsed_json = JSON.parse(response.body)
      expect(parsed_json).to have_key("models")
      expect(parsed_json["models"].size).to eq(1)

      parsed_json["models"].each do |el|
        expect(el).to have_key("model_types")

        el["model_types"].each do |mt|
          %w{name total_price}.each { |attr| expect(mt).to have_key(attr) }
          %w{created_at updated_at}.each { |attr| expect(mt).to_not have_key(attr) }
        end

        %w{created_at updated_at}.each do |attr|
          expect(el).to_not have_key(attr)
        end
      end
    end
  end
end
