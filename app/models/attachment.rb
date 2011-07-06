class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :post
  validates_presence_of :name, :attachment

  def available_name
    name.presence || attachment_url
  end
end
