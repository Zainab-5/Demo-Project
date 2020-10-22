class SubscriptionsController < ApplicationController

  def create
    @plan = Plan.find(params[:plan_id])
    if current_user.subscriptions.create(billing_date: Date.today, plan_id: @plan.id)
      SubscriptionMailer.with(subscription: @subscription).new_subscription_email.deliver
      redirect_to subscriptions_path
    else
      render 'new'
    end
  end

  def new
    @subscription = Subscription.new
    authorize @subscription
    @plans = Plan.all
  end

  def index
    if(current_user.type == 'Buyer')
      @subscriptions = Subscription.where(user_id: current_user.id).includes(:plan)
    else
      @subscriptions = Subscription.all.includes(:plan)
    end
  end

  def show
     @subscription = Subscription.find(params[:id])
     @usages = @subscription.usages
  end

  def billing
    bill_creator = BillCreator.new
    bill_creator.calculate_bill
  end

  private
    def subscription_params
      params.require(:subscription).permit(:billing_date)
    end

end
