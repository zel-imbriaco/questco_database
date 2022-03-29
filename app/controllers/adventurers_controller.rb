class AdventurersController < ApplicationController
  def index
    @adventurers = Adventurer.all
    @parties = Party.all
  end

  def show
    @adventurer = Adventurer.find(params[:id])
    @party = Party.find(@adventurer.party_id)
  end

  def new
    @party = Party.find(params[:id])
  end

  def edit
    @adventurer = Adventurer.find(params[:id])
  end

  def update
    @adventurer = Adventurer.find(params[:id])
    Adventurer.update(@adventurer.id, adventurer_params)
    redirect_to "/adventurers/#{@adventurer.id}"
  end


  def create
    Adventurer.create(adventurer_params)
    redirect_to "/parties/#{adventurer_params[:party_id]}/adventurers"
  end

  private
  def adventurer_params
    params.permit(:name, :level, :alive, :party_id)
  end 
end