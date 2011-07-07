module LocationHelper
  URL = "http://maps.google.com/maps/api/staticmap".freeze
  
  def maps_url(lat, lng)
    coordinates = "#{lat},#{lng}"
    "#{URL}?center=#{coordinates}&zoom=14&size=360x360&sensor=false&markers=color:blue|#{coordinates}"
  end
end