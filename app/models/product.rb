class Product < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable
end
