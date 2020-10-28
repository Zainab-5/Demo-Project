# frozen_string_literal: true

class TransactionsController < ApplicationController
  def create
    begin
      transaction = current_user.transactions.create!(transaction_params)
      authorize transaction
    rescue StandardError
      flash[:notice] = 'Transaction failed'
      redirect_to plans_path
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:fee_charged, :subscription_id)
  end
end
