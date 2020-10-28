# frozen_string_literal: true

class UsagesController < ApplicationController
  def create
    usage = Usage.new(usage_params)
    authorize usage
    if usage.save
      flash[:alert] = 'Usage Successfully entered.'
      redirect_to subscription_path(usage.subscription)
    else
      flash[:notice] = 'Usage not entered. Try Again.'
      redirect_to subscriptions_path
    end
  end

  def new
    @usage = Usage.new(subscription_id: params[:subscription_id], feature_id: params[:feature_id])
    authorize @usage
  end

  def index
    @usages = Usage.all
  end

  private

  def usage_params
    params.require(:usage).permit(:units_used, :subscription_id, :feature_id)
  end
end
