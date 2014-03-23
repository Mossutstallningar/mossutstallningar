module Pageable
  extend ActiveSupport::Concern

  included do
    # friendly_id
    friendly_id :title, use: :slugged

    # validations
    validates :title, presence: true

    # scopes
    scope :published, -> { where(published: true).order(id: :desc) }

    protected

    def should_generate_new_friendly_id?
      slug.blank? || title_changed?
    end
  end
end
