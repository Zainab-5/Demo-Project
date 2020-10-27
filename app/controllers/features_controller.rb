# frozen_string_literal: true

class FeaturesController < ApplicationController
  before_action :find_feature, only: %i[destroy edit update]

  def create
    @feature = Feature.new(feature_params)
    authorize @feature
    if @feature.save
      flash[:notice] = 'Successfully created a feature'
      redirect_to features_path
    else
      render 'new'
    end
  end

  def index
    @features = Feature.all
  end

  def new
    @feature = Feature.new
    authorize @feature
  end

  def destroy
    respond_to do |format|
      format.js if @feature.destroy
    end
  end

  def edit; end

  def update
    if @feature.update!(feature_params)
      flash[:notice] = 'Successfully updated feature.'
      redirect_to features_path
    else
      render 'edit'
    end
  end

  private

  def feature_params
    params.require(:feature).permit(:name, :unit_price, :max_limit, :code)
  end

  def find_feature
    @feature = Feature.find(params[:id])
    authorize @feature
  end
end
