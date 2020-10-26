# frozen_string_literal: true

class FeaturesController < ApplicationController

  def create
    @feature = Feature.new(feature_params)
    if @feature.save!
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
    @feature = Feature.find(params[:id])
    authorize @feature

    respond_to do |format|
      if @feature.destroy!
        format.js
      end
    end
  end

  def edit
    @feature = Feature.find(params[:id])
    authorize @feature
  end

  def update
    @feature = Feature.find(params[:id])
    authorize @feature

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
end
