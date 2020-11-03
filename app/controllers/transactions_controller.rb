# frozen_string_literal: true

class TransactionsController < ApplicationController
  def create
    transaction = current_user.transactions.create!(transaction_params)
    authorize transaction
  rescue StandardError
    flash[:notice] = 'Transaction failed'
    redirect_to plans_path
  end

  private

  def transaction_params
    params.require(:transaction).permit(:fee_charged, :subscription_id)
  end
end
