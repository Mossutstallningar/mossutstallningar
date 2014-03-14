class PageCategory < ActiveRecord::Base
  validates :name, presence: true

  has_many :pages
end
