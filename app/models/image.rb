class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  # http://www.imagemagick.org/script/command-line-processing.php#geometry
  has_attached_file :attachment, styles: {
    small:  '400x400>',
    large:  '1000x1000>'
  }

  validates :position, presence: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: /\Aimage/

  scope :for_gallery, -> { where(for_gallery: true) }
  scope :order_by_position, -> { order(position: :desc) }

  def small
    attachment.url(:small)
  end

  def large
    attachment.url(:large)
  end
end
