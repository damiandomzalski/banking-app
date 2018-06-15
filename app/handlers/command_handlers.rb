module CommandHandlers
  class CreateBankAccount
    include Injectors::ServicesInjector
    include CommandHandler

    def call(command)
      with_aggregate(command.aggregate_id) do |account|
        bank_account_nr = rand.to_s[2..17]
        account.create(bank_account_nr, command.person_id)
      end
    end

    def aggregate_class
      Domains::BankAccount
    end
  end
end
