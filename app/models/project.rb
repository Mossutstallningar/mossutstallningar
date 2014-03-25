class Project < ActiveRecord::Base
  extend FriendlyId
  include Searchable
  include Pageable
end
