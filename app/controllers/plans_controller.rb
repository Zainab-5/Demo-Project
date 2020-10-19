class PlansController < ApplicationController
  def index

  end

  def new
     @plan = Plan.new
  end

  def create
    @user = User.find(current_user.id)
    @plan = @user.plans.new(plan_params)
    if @plan.save
      respond_to do |format|
        format.html { redirect_to plans_path, notice: 'Plan was successfully created.' }
        format.js
      end
    else
      render 'new'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    authorize @plan
    if @plan.update(plan_params)
      redirect_to welcome_index_path
    else
      render 'edit'
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    respond_to do |format|
      if @plan.destroy
        format.html { redirect_to welcome_index_path, notice: 'Plan was successfully created.' }
        format.js
      end
    end
  end

  private
    def plan_params
      params.require(:plan).permit(:name, :fee, feature_ids: [])
    end
end
