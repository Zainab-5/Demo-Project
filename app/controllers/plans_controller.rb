# frozen_string_literal: true

class PlansController < ApplicationController
  before_action :authorize_plan, only: %i[destroy edit update]

  def index
    @plans = Plan.where({}).includes(:features)
  end

  def new
    @plan = Plan.new
    authorize @plan
  end

  def create
    @plan = current_user.plans.new(plan_params)
    authorize @plan

    begin
      @plan.save!
      flash[:alert] = 'Successfully created a plan'
      redirect_to plans_path
    rescue StandardError => e
      flash[:notice] = 'Cannot create a plan'
      redirect_to plans_path
    end
  end

  def edit; end

  def update
    if @plan.update(plan_params)
      flash[:alert] = 'Successfully updated a plan'
      redirect_to plans_path
    else
      render 'edit'
    end
  end

  def destroy
    @plan.destroy!
  rescue StandardError => e
    flash[:notice] = 'Cannot delete a Subscribed Plan'
    redirect_to plans_path
  end

  private

  def plan_params
    params.require(:plan).permit(:name, :fee, feature_ids: [])
  end

  def authorize_plan
    @plan = Plan.find(params[:id])
    authorize @plan
  end
end
