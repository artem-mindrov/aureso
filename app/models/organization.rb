class Organization < ActiveRecord::Base
  enum type: [:show_room, :service, :dealer]
  enum pricing_policy: [:flexible, :fixed, :prestige]

  validates :name, :public_name, presence: true
  validates :name, uniqueness: true

  before_validation(on: :create) do
    self.public_name = self.name if self.public_name.blank?
  end

  private

  def self.inheritance_column
    nil
  end
end
