class Page < ActiveRecord::Base
  validates :title, presence: true

  def self.search(query)
    where('lower(title) LIKE ?', "%#{query.downcase}%") if query.present?
  end
end
