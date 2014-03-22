class Page < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable

  belongs_to :page_category
end
