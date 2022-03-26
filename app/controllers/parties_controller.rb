class PartiesController < ApplicationController
  def index
    @parties = Party.all
  end

  def show
    @party = Party.find(params[:id])
  end

  def adventurers
    @party = Party.find(params[:id])
    @adventurers = Adventurer.where(party_id: @party.id).all
  end
end