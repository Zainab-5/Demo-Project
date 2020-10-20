class TransactionsController < ApplicationController
  def create
    @transaction = current_user.transactions.create(transaction_params)
  end

  private
    def transaction_params
      params.require(:transaction).permit(:fee_charged, :subscription_id)
    end
end
