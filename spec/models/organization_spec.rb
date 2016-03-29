require 'rails_helper'

RSpec.describe Organization, type: :model do
  it "does not use STI" do
    create_list(:organization, 3)
    expect(Organization.all.length).to eq(3)
  end

  it "auto fills public name" do
    org = create(:organization, public_name: nil)
    expect(org).to be_valid
    expect(org.public_name).to eq(org.name)
  end
end
