class FeaturesController < ApplicationController
  def create
    @feature = Feature.new(feature_params)
    if @feature.save
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
      if @feature.destroy
        format.html { redirect_to features_path, notice: 'feature was successfully created.' }
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
    if @feature.update(feature_params)
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
