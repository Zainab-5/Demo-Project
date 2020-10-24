# frozen_string_literal: true

class TransactionMailer < ApplicationMailer
  def new_transaction_email
    @transaction = params[:transaction]
    mail(to: 'zainab.ayaz@devsinc.com', subject: "Your bill has been processed ! '#{@transaction.fee_charged}'")
  end
end
