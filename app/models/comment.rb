class Comment < ActiveRecord::Base
  belongs_to :post
  validates_presence_of :body

  before_create :send_post_to_author

  private

  def send_post_to_author
    CommentsNotifier.to_post_author(self).deliver
  end
end
