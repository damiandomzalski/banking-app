Rails.configuration.to_prepare do
  Rails.configuration.event_store = RailsEventStore::Client.new
  EventStore = Rails.configuration.event_store
end


