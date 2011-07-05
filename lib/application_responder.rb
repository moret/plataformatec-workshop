class ApplicationResponder < ActionController::Responder
  include Responders::FlashResponder
  include Responders::HttpCacheResponder

  # Uncomment this responder if you want your resources to redirect to the collection
  # path (index action) instead of the resource path for POST/PUT/DELETE requests.
  # include Responders::CollectionResponder

  # Handle JS format as navigation, i.e., as HTML
  alias :to_js :to_html
end
