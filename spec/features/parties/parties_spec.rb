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

  it 'User Story 6' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
    party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
    adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
    adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)
    # When I visit the parent index,
    visit '/parties'
    # I see that records are ordered by most recently created first
    expect(page.text.index(party_2.name)).to be < page.text.index(party_1.name)
    # And next to each of the records I see when it was created
    expect(page).to have_content(party_1.created_at)
    expect(page).to have_content(party_2.created_at)
  end

  it 'User Story 7' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
    party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
    adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
    adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)
    # When I visit a parent's show page
    visit "/parties/#{party_1.id}"
    # I see a count of the number of children associated with this parent
    expect(page).to have_content("Adventurer Count: 2")
  end

  it 'User Story 9' do
    # When I visit any page on the site
    # Then I see a link at the top of the page that takes me to the Parent Index
    visit '/parties'
    expect(page).to have_link('Parties Index', href: '/parties')
    visit '/adventurers'
    expect(page).to have_link('Parties Index', href: '/parties')
  end

  it 'User Story 10' do
    party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
    party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
    adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
    adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)
    # When I visit a parent show page ('/parents/:id')
    visit "/parties/#{party_1.id}"
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    expect(page).to have_link("Link", href: "/parties/#{party_1.id}/adventurers")
  end
end