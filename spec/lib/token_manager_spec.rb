require 'rails_helper'
require 'token_manager'
require 'timecop'

class MockRequest
  def remote_ip; "127.0.0.1"; end
  def user_agent; "Chrome"; end
end

describe TokenManager, type: :model do
  let(:user) { create(:user, auth_tokens: auth_tokens) }
  let(:auth_tokens) { create_list(:auth_token, 3) }
  let(:auth_token) { create(:auth_token) }
  let(:request) { MockRequest.new }

  describe "create_token" do
    it "creates a new token" do
      Timecop.freeze
      expect(user.auth_tokens).to receive(:create!).with(last_used_at: Time.now,
                                                         ip: request.remote_ip,
                                                         user_agent: request.user_agent).and_return(auth_token)
      described_class.create_token(user, request)
    end

    it "returns the token" do
      allow(user.auth_tokens).to receive(:create!).and_return(auth_token)
      expect(described_class.create_token(user, request)).to eq("token")
    end
  end

  describe "purge_tokens" do
    it "deletes all the user's tokens" do
      expect(user.auth_tokens).to receive_message_chain(:order, :destroy_all)
      described_class.purge_tokens(user)
    end
  end
end