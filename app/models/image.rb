class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  has_attached_file :attachment, styles: {
    small:  '400x400',
    medium: '800x450',
    large:  '1600x900'
  }

  validates :position, presence: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, content_type: /\Aimage/

  scope :for_gallery, -> { where(for_gallery: true) }
  scope :order_by_position, -> { order(position: :desc) }

  def small
    attachment.url(:small)
  end

  def medium
    attachment.url(:medium)
  end

  def large
    attachment.url(:large)
  end
end
