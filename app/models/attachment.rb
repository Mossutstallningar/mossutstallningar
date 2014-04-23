class Attachment < ActiveRecord::Base
  belongs_to :attachable, polymorphic: true

  has_attached_file :attachment

  validates :name, presence: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: ['application/zip', 'application/pdf', 'audio/mpeg', 'audio/x-mpeg', 'audio/mp3', 'audio/x-mp3', 'audio/mpeg3', 'audio/x-mpeg3', 'audio/mpg', 'audio/x-mpg', 'audio/x-mpegaudio']

  def url
    attachment.url
  end
end
