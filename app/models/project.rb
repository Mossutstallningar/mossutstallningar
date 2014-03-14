class Project < ActiveRecord::Base
  include Searchable

  has_many :images

  validates :title, presence: true

  accepts_nested_attributes_for :images, allow_destroy: true
end
