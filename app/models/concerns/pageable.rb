module Pageable
  extend ActiveSupport::Concern

  included do
    # friendly_id
    friendly_id :title, use: :slugged

    # validations
    validates :title, presence: true

    # scopes
    scope :published, -> { where(published: true).order(id: :desc) }

    # relations
    has_many :images, as: :imageable

    # nested attributes
    accepts_nested_attributes_for :images, allow_destroy: true

    protected

    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
  end
end
