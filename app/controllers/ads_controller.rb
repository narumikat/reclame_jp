class AdsController < ApplicationController
  before_action :authenticate_user!
  
  def new
    @ad = Ad.new
  end

  def create
    @ad = Ad.new(ad_params)

    if @ad.save
      redirect_to ads_path, notice: 'Anúncio criado com sucesso.'
    else
      flash[:alert] = 'Falha ao salvar o anúncio: ' + @ad.errors.full_messages.to_sentence
      render :new
    end
  end

  def index
    @ads = Ad.all.order(created_at: :desc)
  end

  def show
    @ad = Ad.find(params[:id])
  end

  private

  def ad_params
    params.require(:ad).permit(:title, :ad_type, :location, :description, :url, :active, :image)
  end
end
