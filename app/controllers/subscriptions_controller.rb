class SubscriptionsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @plan = Plan.find(params[:plan_id])
    @subscription = @user.subscriptions.create(billing_date: params[:billing_date], plan_id: @plan.id)
    redirect_to welcome_index_path
  end

  private
    def subscription_params
      params.require(:subscription).permit(:billing_date)
    end

end
