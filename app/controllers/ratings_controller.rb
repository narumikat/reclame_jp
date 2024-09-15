# app/controllers/ratings_controller.rb
class RatingsController < ApplicationController
  def create
    @rating = Rating.new(rating_params)
    if @rating.save
      redirect_to @rating.resource, notice: 'Avaliação enviada com sucesso.'
    else
      redirect_to @rating.resource, alert: 'Erro ao enviar a avaliação.'
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:value, :resource_id, :resource_type)
  end
end
