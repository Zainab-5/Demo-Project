class PlansController < ApplicationController

    def create
      @user = User.find(params[:user_id])
      @plan = @user.plans.create(plan_params)
      redirect_to welcome_index_path
    end

    private
      def plan_params
        params.require(:plan).permit(:name, :fee, feature_ids: [])
      end


end
