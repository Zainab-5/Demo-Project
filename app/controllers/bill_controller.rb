# frozen_string_literal: true

class BillController < ApplicationController
  def billing
    bill_creator = BillCreator.new(params[:id])

    flash[:alert] = if bill_creator.calculate_bill
                      'Successfully Charged User!'
                    else
                      'User has already been charged !'
                    end
    redirect_to subscriptions_path
  end
end
