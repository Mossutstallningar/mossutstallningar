class Project < ActiveRecord::Base
  include Searchable
  extend FriendlyId

  friendly_id :title, use: :slugged

  has_many :images

  validates :title, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true

  protected

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
