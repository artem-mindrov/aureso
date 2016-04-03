require 'rails_helper'

RSpec.describe SessionsController, type: :request do
  before { allow(TokenManager).to receive(:create).and_return(auth_token.body) }

  let!(:user) { create(:user, password: "valid-password") }
  let!(:auth_token) { create(:auth_token, user_id: user.id) }
  let(:parsed_response) { JSON.parse(response.body) }

  describe "POST #create" do
    context "with valid credentials" do
      it "logs in" do
        post "/sessions", { user: { email: user.email, password: "valid-password" } }

        expect(response).to be_success
        expect(parsed_response).to eq({ "user_email" => user.email, "auth_token" => auth_token.body })
      end
    end

    context "with invalid credentials" do
      it "fails for invalid passwords" do
        post "/sessions", { user: { email: user.email, password: "invalid-password" } }
        expect(response.status).to eq(401)
      end
    end
  end

  describe "DELETE #destroy" do
    context "with valid credentials" do
      it "logs out" do
        delete "/sessions", nil, { "HTTP_X_USER_EMAIL" => user.email, "HTTP_X_AUTH_TOKEN" => auth_token.body }
        expect(response).to be_success
      end
    end

    context "with invalid credentials" do
      it "returns 'unauthorized'" do
        delete "/sessions"
        expect(response.status).to eq(401)
      end
    end
  end
end
