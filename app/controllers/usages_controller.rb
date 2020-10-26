# frozen_string_literal: true

class UsagesController < ApplicationController
  def create
    @usage = Usage.create!(usage_params)
    redirect_to subscriptions_path
  end

  def new
    @usage = Usage.new(subscription_id: params[:subscription_id], feature_id: params[:feature_id])
  end

  def index
    @usages = Usage.all
  end

  private

  def usage_params
    params.require(:usage).permit(:units_used, :subscription_id, :feature_id)
  end
end
