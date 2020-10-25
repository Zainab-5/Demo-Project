# frozen_string_literal: true

class UsagesController < ApplicationController
  def create
    @usage = Usage.create(usage_params)
    redirect_to plans_path
  end

  def new
    @usage = Usage.new
    @subscriptions = Subscription.all
    @features = []

    if params[:subscription].present?
      plan = Subscription.find(params[:subscription]).plan
      @features = plan.features
    end
    if request.xhr?
      respond_to do |format|
        format.json do
          render json: { features: @features }
        end
      end
    end
  end

  def index
    @usages = Usage.all
  end

  private

  def usage_params
    params.require(:usage).permit(:units_used, :subscription_id, :feature_id)
  end
end
