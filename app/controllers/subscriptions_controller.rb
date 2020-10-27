# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  def create
    @subscription = current_user.subscriptions.new(plan_id: params[:plan_id], billing_date: params[:billing_date])
    begin
      if @subscription.save!
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
                       current_user.subscriptions.includes(:plan, :user)
                       #Subscription.where(user_id: current_user.id).includes(:plan, :user)
                     else
                       Subscription.all.includes(:plan)
                     end
  end

  def show
    @subscription = Subscription.includes(:usages, { plan: :features }).find(params[:id])

    @plan = @subscription.plan
    @usages = @subscription.usages
  end

  private

  def subscription_params
    params.require(:billing_date, :plan_id)
  end
end
