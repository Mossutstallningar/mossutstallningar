class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  has_attached_file :attachment

  validates :name, presence: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: ['application/zip', 'application/pdf']
end
