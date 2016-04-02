require 'rails_helper'

RSpec.describe AuthTokenStrategy, type: :model do
  let(:user) { create(:user) }
  let(:token) { create(:auth_token, user_id: user.id) }

  let(:env) {
    { "HTTP_X_USER_EMAIL" => user.email,
      "HTTP_X_AUTH_TOKEN" => token.body } }

  subject { described_class.new(nil) }

  describe "#valid?" do
    describe "with valid credentials" do
      before { allow(subject).to receive(:env).and_return(env) }
      it { is_expected.to be_valid }
    end

    context "with invalid credentials" do
      before { allow(subject).to receive(:env).and_return({}) }
      it { is_expected.not_to be_valid }
    end
  end

  describe "#authenticate!" do
    context "with valid credentials" do
      before { allow(subject).to receive(:env).and_return(env) }

      it "authenticates" do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        expect(TokenManager).to receive_message_chain(:new, :find_token).with(user, token.body).and_return(token)
        expect(subject).to receive(:success!).with(user)
        subject.authenticate!
      end

      it "updates the token used time" do
        expect(subject).to receive(:update_token).with(token)
        subject.authenticate!
      end
    end

    context "with invalid user" do
      before { allow(subject).to receive(:env).and_return( "HTTP_X_USER_EMAIL" => "invalid@email",
                                                           "HTTP_X_AUTH_TOKEN" => "invalid-token" ) }

      it "fails" do
        expect(User).to receive(:find_by).with(email: "invalid@email").and_return(nil)
        expect(TokenManager).not_to receive(:new)
        expect(subject).to receive(:fail!)
        subject.authenticate!
      end
    end

    context "with invalid token" do
      before { allow(subject).to receive(:env).and_return( "HTTP_X_USER_EMAIL" => user.email,
                                                           "HTTP_X_AUTH_TOKEN" => "invalid-token") }

      it "fails" do
        expect(User).to receive(:find_by).with(email: user.email).and_return(user)
        expect(TokenManager).to receive_message_chain(:new, :find_token).with(user, "invalid-token").and_return(nil)
        expect(subject).to receive(:fail!)
        subject.authenticate!
      end
    end
  end

end