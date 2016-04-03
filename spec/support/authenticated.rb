require 'rails_helper'

shared_examples "authenticated" do
  describe "authentication" do
    def try_with(email, token)
      get path, nil, { "HTTP_X_USER_EMAIL" => email, "HTTP_X_AUTH_TOKEN" => token }
      expect(response.status).to eq(401)
    end

    it "returns 'unauthorized' without credentials" do
      try_with(nil, nil)
    end

    it "returns 'unauthorized' without a valid token" do
      try_with(create(:user).email, nil)
    end
  end
end