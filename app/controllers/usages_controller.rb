class UsagesController < ApplicationController
  def create
    @usage = Usage.create(usage_params)
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

  def show
    @usages = Usage.find(params[:id])
    redirect_to plans_path
  end

  def index
    @usage = Usage.all
  end

  def billing
    bill_creator = BillCreator.new
    bill_creator.calculate_bill
  end


  private
    def usage_params
      params.require(:usage).permit(:units_used,:subscription_id, :feature_id)
    end
end
