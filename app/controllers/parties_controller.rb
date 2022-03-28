class PartiesController < ApplicationController
  def index
    @parties = Party.order(created_at: :desc)
  end

  def new
  end

  def show
    @party = Party.find(params[:id])
    @adventurers = Adventurer.where(party_id: @party.id).count
  end

  def adventurers
    @party = Party.find(params[:id])
    @adventurers = Adventurer.where(party_id: @party.id).all
  end

  def create
    binding.pry
    Party.create(party_params)
    redirect_to '/parties'
  end

  private
  def party_params
    params.permit(:name, :rank, :active)
  end
end