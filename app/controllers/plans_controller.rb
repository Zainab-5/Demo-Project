class PlansController < ApplicationController
  def index
   @plan = Plan.all
  end

  def new
     @plan = Plan.new
  end

  def create
    @plan = current_user.plans.new(plan_params)
    if @plan.save
      redirect_to plans_path
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
      redirect_to plans_path
    else
      render 'edit'
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    respond_to do |format|
      if @plan.destroy
        format.html { redirect_to plans_path, notice: 'Plan was successfully created.' }
        format.js
      end
    end
  end

  private
    def plan_params
      params.require(:plan).permit(:name, :fee, feature_ids: [])
    end
end
