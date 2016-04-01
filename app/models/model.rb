class Model < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :organization
  has_many :model_types

  validates :name, presence: true, uniqueness: true
  validates :organization_id, presence: true

  def model_slug
    self.slug
  end
end
