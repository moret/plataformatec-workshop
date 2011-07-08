class Post < ActiveRecord::Base
  has_many :comments
  has_many :attachments
  belongs_to :user
  validates_presence_of :title, :body
  validates_uniqueness_of :slug, :if => :slug_changed?

  validate :has_user
  accepts_nested_attributes_for :attachments, :reject_if => :all_blank

  before_save :do_geolocalization, :if => :location_changed?

  def has_coordinates?
    self.lat? && self.lng?
  end

  def is_author?(author)
    author && self.user == author
  end

  scope :public_listing, order('created_at desc')
  
  private

  def do_geolocalization
    self.lat, self.lng = Geocode.get(self.location)
  rescue Geocode::Error
    self.lat, self.lng = nil, nil
  end

  def has_user
    raise "@post.user is nil" unless user
  end
end
