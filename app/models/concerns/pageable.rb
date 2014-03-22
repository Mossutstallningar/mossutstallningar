module Pageable
  extend ActiveSupport::Concern

  included do
    # friendly_id
    friendly_id :title, use: :slugged

    # validations
    validates :title, presence: true

    # scopes
    default_scope { order(created_at: :desc) }
    scope :published, -> { where(published: true) }
  end

  module ClassMethods
    protected

    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
  end
end
