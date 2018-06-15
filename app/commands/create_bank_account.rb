module Commands
  class CreateBackAccount < Command
    attr_accessor :person_id, :bank_account_nr, :id

    validates :person_id, :bank_account_nr, persence: true
    alias :aggregate_id :id
  end
end
