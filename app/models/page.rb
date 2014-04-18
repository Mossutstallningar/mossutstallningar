class Page < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable

  belongs_to :page_category

  scope :order_by_position, -> { order(position: :asc) }
end
