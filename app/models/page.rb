class Page < ActiveRecord::Base
  include Searchable
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true

  belongs_to :page_category

  protected

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
