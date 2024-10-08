class AdsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ad, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:load_banner, :load_sm_banner, :load_card, :load_sidecard]
  
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
    authorize @ad
  end

  def edit
    authorize @ad
  end

  def update
    authorize @ad
    if @ad.update(ad_params)
      redirect_to ads_path, notice: 'Anúncio atualizado com sucesso.'
    else
      flash[:alert] = 'Falha ao atualizar o anúncio: ' + @ad.errors.full_messages.to_sentence
      render :edit
    end
  end
    
  def load_banner
    @banner_ads = Ad.where(ad_type: 'Banner', active: true).order("RANDOM()").first
      render partial: 'ads/banner', locals: { ad: @banner_ads }
  end

  def load_sm_banner
    @banner_sm_ads = Ad.where(ad_type: 'Banner-sm', active: true).order("RANDOM()").first
      render partial: 'ads/banner_sm', locals: { ad: @banner_sm_ads }
  end
  
  def load_card
    @card_ads = Ad.where(ad_type: 'Card', active: true).order("RANDOM()").first
    render partial: 'ads/card', locals: { ad: @card_ads }
  end

  def load_sidecard
    @sidecard_ads = Ad.where(ad_type: 'Sidecard', active: true)
    @sidecard_ad = @sidecard_ads.sample
    render partial: 'ads/sidecard', locals: { ad: @sidecard_ad }
  end
  

  def destroy
    authorize @ad
    @ad.destroy
    redirect_to ads_path, notice: 'Anúncio excluído com sucesso.'
  end

  def toggle_active
    ad = Ad.find(params[:id])
    ad.update(active: params[:active])

    respond_to do |format|
      format.json { render json: { success: true } }
      format.html { redirect_to ads_path }
    end
  end

  private

  def ad_params
    params.require(:ad).permit(:title, :ad_type, :location, :description, :url, :active, :image)
  end

  def find_ad
    @ad = Ad.find_by(id: params[:id])
    unless @ad
      flash[:alert] = "Anúncio não encontrado."
      redirect_to ads_path
    end
  end
  
end
