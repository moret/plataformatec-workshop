module AcceptanceExampleGroup
  extend ActiveSupport::Concern

  include Capybara::DSL
  include Capybara::RSpecMatchers
  include Rails.application.routes.url_helpers

  # Same as def self.included(base); base.metadata[:type] = :acceptance; end
  included do
    metadata[:type] = :acceptance
  end
end
