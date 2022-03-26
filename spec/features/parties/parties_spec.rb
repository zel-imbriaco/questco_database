require 'rails_helper'

RSpec.describe '/parties endpoint', type: :feature do

  it 'User Story 1' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 2, active: true)
    party_2 = Party.create(name: "Vox Machina", rank: 1, active: false)

    # When I visit '/parents'
    visit '/parties'
    # Then I see the name of each parent record in the system
    expect(page).to have_content(party_2.name)
    expect(page).to have_content(party_1.name)
  end

  it 'User Story 2' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 2, active: true)
    party_2 = Party.create(name: "Vox Machina", rank: 1, active: true)

    # When I visit '/parents/:id'
    visit "/parties/#{party_1.id}"
    # Then I see the parent with that id including the parent's attributes:
    # - data from each column that is on the parent table
    expect(page).to have_content(party_1.name)
    expect(page).to have_content(party_1.rank)
    expect(page).to have_content(party_1.active)
  end

  it 'User Story 5' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
    party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
    adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
    adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)
    # When I visit '/parents/:parent_id/child_table_name'
    visit "/parties/#{party_1.id}/adventurers"
    # Then I see each Child that is associated with that Parent with each Child's attributes:
    expect(page).to have_content(adventurer_1.name)
    expect(page).to have_content(adventurer_1.level)
    expect(page).to have_content(adventurer_1.alive)
    expect(page).to have_content(adventurer_2.name)
    expect(page).to have_content(adventurer_2.level)
    expect(page).to have_content(adventurer_2.alive)
  end
end