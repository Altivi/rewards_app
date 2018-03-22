module ApiAuthentications
  class Email < Base
    def authenticate
      @account = Account.find_by_email(@account_params[:email])
      if @account && @account.valid_password?(@account_params[:password])
        @session = @account.sessions.build(@session_params)
        @account.save
      else
        @errors << 'Email/Password combination is incorrect'
      end
      @errors.empty?
    end
  end
end
