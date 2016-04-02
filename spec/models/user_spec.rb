require 'rails_helper'

RSpec.describe User, type: :model do
  it { expect(build(:user, password: nil)).to_not be_valid }
  it { expect(build(:user, password: "foo")).to_not be_valid }
  it { expect(build(:user, email: "user+tag@email.com")).to be_valid }
end
