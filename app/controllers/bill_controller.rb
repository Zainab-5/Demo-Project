class BillController < ApplicationController
  def billing
    bill_creator = BillCreator.new
    if bill_creator.calculate_bill(params[:id])
       flash[:notice] = 'Successfully Charged User!'
    else
      flash[:notice] = 'User has already been charged !'
    end
    redirect_to subscriptions_path
  end
end
