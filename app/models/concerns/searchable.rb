module Searchable
  extend ActiveSupport::Concern

  included do
    include PgSearch

    pg_search_scope :search, against: {
      title: 'A',
      body: 'B'
    }
  end
end
