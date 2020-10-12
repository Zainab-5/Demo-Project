class FeaturesController < ApplicationController
  def create
    @user = User.find(params[:plan_id])
    @plan = @user.plans.create(feature_params)
    redirect_to welcome_index_path
  end

  private
    def plan_params
      params.require(:feature).permit(:name, :unit_price)
    end
end
