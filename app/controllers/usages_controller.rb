class UsagesController < ApplicationController
  def create
    @usage = Usage.create(units_used: params[:usage][:units_used], subscription_id: params[:subscription_id], feature_id: params[:feature_id])
    redirect_to plans_path
  end

  def new
    @usage= Usage.new
    @subscriptions = Subscription.all
    @features = []
    if params[:subscription].present?
      plan = Subscription.find( params[:subscription]).plan
      @features = plan.features
    end
    if request.xhr?
      respond_to do |format|
        format.json {
          render json: {features: @features}
        }
        format.js
      end
    end
  end

  private
    def usage_params
      params.require(:usage).permit(:units_used)
    end
end
