class Api::V1::SessionsController < Api::V1::BaseController
  skip_before_action :current_account

  def create
    authentication = ::ApiAuthentications::Email.new(authentication_params)
    if authentication.authenticate
      set_current_session(authentication)
      render 'api/v1/accounts/show'
    else
      render_error(422, 'NotValid', authentication.errors.join(', '))
    end
  end

  def destroy
    current_session.destroy
    render_success('You have successfully signed out')
  end

  private

  def set_current_session(authentication)
    @current_session = authentication.session
    @account = authentication.account
    set_access_token_to_header (@current_session) 
  end

  def authentication_params
    {
      account: account_params,
      session: session_params
    }
  end

  def account_params
    params.require(:account).permit(
      :email,
      :password,
      :name
    )
  end

  def session_params
    params.require(:session).permit(
      :device_platform,
      :device_token
    )
  end
end
