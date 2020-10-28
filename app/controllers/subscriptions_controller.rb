# frozen_string_literal: true

class SubscriptionsController < ApplicationController


  def create
    @subscription = current_user.subscriptions.new(subscription_params)
    authorize @subscription

    begin
      @subscription.save!
      flash[:alert] = 'Successfully subscribed to this plan'
      redirect_to subscriptions_path
    rescue StandardError
      flash[:notice] = 'Already subscribed to this plan'
      redirect_to plans_path
    end
  end

  def index
    @subscriptions = if current_user.type == 'Buyer'
                       current_user.subscriptions.includes(:plan, :user)
                     else
                       Subscription.where({}).includes(:plan)
                     end
  end

  def show
    @subscription = Subscription.includes(:usages, { plan: :features }).find(params[:id])

    @plan = @subscription.plan
    @usages = @subscription.usages.where(is_billed: false)
  end

  private

  def subscription_params
    {
      plan_id: params[:plan_id],
      billing_date: params[:billing_date]
    }
  end

  def authorize_subscription
    authorize @subscription
  end
end
