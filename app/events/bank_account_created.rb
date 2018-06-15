module Events
  class BankAccountCreated < RailsEventStore::Event
    def self.create(attrs)
      new(data: attrs)
    end
  end
end



