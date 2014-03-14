class PageCategory < ActiveRecord::Base
  validates :name, presence: true
end
