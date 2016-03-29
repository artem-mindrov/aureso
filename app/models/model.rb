class Model < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :organization

  validates :name, presence: true, uniqueness: true
  validates :organization_id, presence: true
end
