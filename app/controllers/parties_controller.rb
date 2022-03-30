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
    if params[:level]
      @adventurers = Adventurer.where('party_id = :party_id AND level > :level', :party_id => params[:id], :level => params[:level]).order(params[:sort]).all
    else
      @adventurers = Adventurer.where(party_id: @party.id).order(params[:sort]).all
    end
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

  def destroy
    Adventurer.where(party_id: params[:id]).destroy_all
    Party.destroy(params[:id])
    redirect_to '/parties'
  end

  private
  def party_params
    params.permit(:name, :rank, :active)
  end
end