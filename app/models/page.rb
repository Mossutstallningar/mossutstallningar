class Page < ActiveRecord::Base
  include Searchable

  validates :title, presence: true

  belongs_to :page_category
end
