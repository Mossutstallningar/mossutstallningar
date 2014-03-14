module Searchable
  extend ActiveSupport::Concern

  module ClassMethods
    def search(query)
      where('lower(title) LIKE ?', "%#{query.downcase}%") if query.present?
    end
  end
end
