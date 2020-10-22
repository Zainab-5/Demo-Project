class BillController < ApplicationController
  def billing
    bill_creator = BillCreator.new
    byebug
    bill_creator.calculate_bill(params[:id])
    redirect_to plans_path
  end
end
