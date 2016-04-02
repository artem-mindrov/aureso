require 'pricing_policy'

class ModelType < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  belongs_to :model

  validates :name, :base_price, presence: true
  validates :name, uniqueness: { scope: :model }
  validates :base_price, numericality: { greater_than: 0 }

  def model_type_slug
    self.slug
  end

  def pricing_policy
    self.model.organization.pricing_policy
  end

  def total_price
    "PricingPolicy::#{self.pricing_policy.classify}".constantize.new.total_for(self.base_price)
  end
end
