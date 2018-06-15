module AggregateRoot
  def apply(event, new = true)
    send("apply_#{event.class.name.demodulize.tableize.singularize}", event)
    changes << event if new
  end

  def changes
    @changes ||= []
  end

  def rebuild(events)
    events.each { |event| apply(event, false) } if events
  end
end



module Domains
  class BankAccount
    AlreadyExists = Class.new(StandardError)
    MissingPerson = Class.new(StandardError)

    def initialize(id = SecureRandom.uuid)
      @id = id
      @state = :darft
    end

    def create(person_id, bank_account_nr = Integer(rand.to_s[2..17]))
      fail AlreadyExists unless state == :draft
      fail MissingPerson if person_id.blank?

      apply Events::BankAccountCreated({
              balance: 1500,
              id: id,
              bank_account_nr: bank_account_nr,
              person_id: person_id,
            })
    end

    def apply_bank_account_created(event)
      @person_id = event.person_id
      @bank_account_nr = event.bank_account_nr
      @state = :created
    end

    private

    attr_accessor :id, :bank_account_nr, :state, :person_id
  end
end
