# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def create
    begin

      @subscription = Subscription.new(plan_id: params[:plan_id], billing_date: params[:billing_date], user_id: current_user.id)

      if @subscription.save

        SubscriptionMailer.with(subscription: @subscription).new_subscription_email.deliver
        flash[:notice] = 'Successfully subscribed to this plan'
        redirect_to subscriptions_path
      else
        render 'new'
      end
    rescue StandardError => e
      flash[:notice] = 'Already subscribed to this plan'
      redirect_to plans_path
    end
  end

  def index
    @subscriptions = if current_user.type == 'Buyer'
                       Subscription.where(user_id: current_user.id).includes(:plan)
                     else
                       Subscription.all.includes(:plan)
                     end
  end

  def show
    @subscription = Subscription.includes(:plan).find(params[:id])
    @plan = @subscription.plan
    @usages = @subscription.usages
  end

  private

  def subscription_params
    params.require(:billing_date, :plan_id)
  end
end
