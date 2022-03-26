require 'rails_helper'

RSpec.describe '/adventurers endpoint', type: :feature do 

  it 'User Story 3' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
    adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
    adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)

    # When I visit '/child_table_name'
    visit '/adventurers'
    # Then I see each Child in the system including the Child's attributes:
    expect(page).to have_content(adventurer_1.name)
    expect(page).to have_content(adventurer_1.level)
    expect(page).to have_content(adventurer_1.alive)
    expect(page).to have_content(adventurer_2.name)
    expect(page).to have_content(adventurer_2.level)
    expect(page).to have_content(adventurer_2.alive)
  end
end