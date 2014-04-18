class Project < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable

  scope :order_by_position, -> { order(position: :asc) }
end
