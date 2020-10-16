class SubscriptionsController < ApplicationController

  def create
    @user = User.find(current_user.id)
    @plan = Plan.find(params[:plan_id])
    @subscription = @user.subscriptions.create(billing_date: params[:subscription][:billing_date], plan_id: @plan.id)
    redirect_to subscriptions_path
  end

  def new
    @subscription = Subscription.new
  end

  def index
    if(current_user.type == 'Buyer')
      @subscriptions = Subscription.where(user_id: current_user.id).all
    else
      @subscriptions = Subscription.all
    end
  end

  def show

  end

  private
    def subscription_params
      params.require(:subscription).permit(:billing_date)
    end

end
