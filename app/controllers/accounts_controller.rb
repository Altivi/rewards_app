class AccountsController < ApplicationController
  def edit; end;

  def update
    if current_account.update_with_password(account_params)
      flash[:success] = 'Account updated'
      bypass_sign_in(current_account)
      redirect_to root_path
    else
      flash[:error] = current_account.errors.full_messages.join(', ')
      redirect_to edit_account_path
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
