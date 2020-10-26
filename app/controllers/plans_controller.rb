# frozen_string_literal: true

class PlansController < ApplicationController
  def index
    @plans = Plan.all.includes(:features)
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @plan = current_user.plans.new(plan_params)
    authorize @plan

    if @plan.save!
      flash[:notice] = 'Successfully created a plan'
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

    if @plan.update!(plan_params)
      flash[:notice] = 'Successfully updated a plan'
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
          format.js
        end
      end
    rescue StandardError => e
      flash[:notice] = 'Cannot delete a Subscribed Plan'
      redirect_to plans_path
    end
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :fee, feature_ids: [])
  end
end
