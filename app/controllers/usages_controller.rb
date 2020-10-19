class UsagesController < ApplicationController
  def create
    @user = User.find(current_user.id)
    @usage =  @user.transactions.create(transaction_params)
  end

  def new
=begin
    @usage = Usage.new
    if params[:subscription_id].present?
      byebug
     puts "hello"
    end
=end
    @usage= Usage.new
    @subscriptions = Subscription.all
    @features = []
    if params[:subscription_id].present?
      plan = Plan.find_by(subscription_id: params[:subscription_id])
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
      params.require(:usage).permit(:feature_id, :subscription_id,:units_used)
    end
end
