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
    @adventurers = Adventurer.where(party_id: @party.id).order(params[:sort]).all
  end

  def edit
    @party = Party.find(params[:id])
  end

  def update
    @party = Party.find(params[:id])
    Party.update(@party.id, party_params)
    redirect_to "/parties/#{@party.id}"
  end

  def create
    Party.create(party_params)
    redirect_to '/parties'
  end

  private
  def party_params
    params.permit(:name, :rank, :active)
  end
end