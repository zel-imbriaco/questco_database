require 'rails_helper'

RSpec.describe '/parties endpoint', type: :feature do

  it 'Returns all party names' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)

    # When I visit '/parents'
    visit '/parents'
    # Then I see the name of each parent record in the system
    expect(page).to have_content(party_1.name)
  end
end