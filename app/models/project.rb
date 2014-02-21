class Project < ActiveRecord::Base
  validates :title, presence: true

  def self.search(query)
    where('title LIKE ?', "%#{query}%")
  end
end
