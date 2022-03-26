class AdventurersController < ApplicationController
  def index
    @adventurers = Adventurer.all
    @parties = Party.all
  end

  def show
    @adventurer = Adventurer.find(params[:id])
    @party = Party.find(@adventurer.party_id)
  end
end