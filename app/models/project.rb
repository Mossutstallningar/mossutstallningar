class Project < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable

  has_many :images

  accepts_nested_attributes_for :images, allow_destroy: true
end
