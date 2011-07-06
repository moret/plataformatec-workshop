class Attachment < ActiveRecord::Base
  mount_uploader :attachment, AttachmentUploader
  belongs_to :post
  validates_presence_of :name, :attachment
end
