class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  validates_presence_of :title, :body

  validate :has_user

  def is_author?(author)
    author && self.user == author
  end
  
  private

  def has_user
    raise "@post.user is nil" unless user
  end
end
