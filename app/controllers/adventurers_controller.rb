class AdventurersController < ApplicationController
  def index
    @adventurers = Adventurer.all
    @parties = Party.all
  end
end