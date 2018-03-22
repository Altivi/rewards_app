class Api::V1::AccountsController < Api::V1::BaseController
  def show
    @account = current_account
  end

  def update
    if current_account.update_with_password(account_params)
      render :show
    else
      render_error(422, 'NotValid', current_account.errors.full_messages.join(', '))
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :email,
      :name,
      :password,
      :current_password,
      :password_confirmation
    )
  end
end
