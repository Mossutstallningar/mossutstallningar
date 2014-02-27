class Image < ActiveRecord::Base
  belongs_to :project

  validates :position, presence: true

  default_scope { order(:position) }
end
