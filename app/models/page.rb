class Page < ActiveRecord::Base
  include Searchable
  extend FriendlyId

  friendly_id :title, use: :slugged

  validates :title, presence: true

  belongs_to :page_category

  default_scope  { order(created_at: :desc) }

  protected

  def should_generate_new_friendly_id?
    slug.blank? || title_changed?
  end
end
