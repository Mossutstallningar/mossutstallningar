class Image < ActiveRecord::Base
  belongs_to :project

  has_attached_file :attachment, styles: {
    small: "800x450#",
    large: "1600x900#",
  },
  convert_options: {
    large: "-quality 60"
  }

  validates :position, presence: true
  validates_attachment_presence :attachment
  validates_attachment_content_type :attachment, :content_type => /\Aimage/

  default_scope { order(:position) }
end
