class TransactionsController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @transaction = @user.transactions.create(transaction_params)
  end

  private
    def transaction_params
      params.require(:transaction).permit(:fee_charged, :subscription_id)
    end
end
