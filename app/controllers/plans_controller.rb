class PlansController < ApplicationController
  def index
    @plan = Plan.all
  end

  def new
    @plan = Plan.new
  end

  def create
    @plan = current_user.plans.new(plan_params)
    authorize @plan
    if @plan.save
      redirect_to plans_path
    else
      render 'new'
    end
  end

  def edit
    @plan = Plan.find(params[:id])
    authorize @plan
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
    authorize @plan
    begin
      respond_to do |format|
        if @plan.destroy
          format.html { redirect_to plans_path, notice: 'Plan was successfully destroyed.' }
          format.js
        end
      end
    rescue => exception
      flash[:notice] = 'Cannot delete a Subscribed Plan'
      redirect_to plans_path
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :fee, feature_ids: [])
  end
end
