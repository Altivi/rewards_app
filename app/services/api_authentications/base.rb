module ApiAuthentications
  class Base
    attr_accessor :account, :session, :errors

    def initialize(options)
      @account_params = options[:account]
      @session_params = options[:session]
      @errors = []
    end
  end
end
