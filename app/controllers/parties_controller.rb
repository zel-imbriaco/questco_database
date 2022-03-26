class PartiesController < ApplicationController
  def index
    @parties = Party.order(created_at: :desc)
  end

  def show
    @party = Party.find(params[:id])
  end

  def adventurers
    @party = Party.find(params[:id])
    @adventurers = Adventurer.where(party_id: @party.id).all
  end
end