require 'rails_helper'

RSpec.describe '/adventurers endpoint', type: :feature do 

  party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
  party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
  adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
  adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: true, party_id: party_1.id)
  adventurer_3 = Adventurer.create(name: "Bertrand Bell", level: 4, alive: false, party_id: party_2.id)

  it 'User Story 3' do
    # When I visit '/child_table_name'
    visit '/adventurers'
    # Then I see each Child in the system including the Child's attributes:
    expect(page).to have_content(adventurer_1.name)
    expect(page).to have_content(adventurer_1.level)
    expect(page).to have_content(adventurer_1.alive)
    expect(page).to have_content(adventurer_2.name)
    expect(page).to have_content(adventurer_2.level)
    expect(page).to have_content(adventurer_2.alive)
    expect(page).to have_no_content(party_2.name)
  end

  it 'User Story 4' do

    # When I visit '/child_table_name/:id'
    visit "/adventurers/#{adventurer_2.id}"
    # Then I see the child with that id including the child's attributes:
    expect(page).to have_content(adventurer_2.name)
    expect(page).to have_content(adventurer_2.level)
    expect(page).to have_content(adventurer_2.alive)
    expect(page).to have_content(party_1.name)
  end

  it 'User Story 8' do
    # When I visit any page on the site
    # Then I can see a link to the /adventurers endpoint named 'Adventurer Index'
    visit '/parties'
    expect(page).to have_link('Adventurers Index', href: '/adventurers')
    visit '/adventurers'
    expect(page).to have_link('Adventurers Index', href: '/adventurers')
  end

  it 'User Story 13' do

    # When I visit a Parent Childs Index page
    visit "/parties/#{party_1.id}/adventurers"
    # Then I see a link to add a new adoptable child for that parent "Create Child"
    # When I click the link
    click_link "Create New Adventurer"
    # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new adoptable child
    expect(current_path).to eq("/parties/#{party_1.id}/adventurers/new")
    # When I fill in the form with the child's attributes:
    fill_in "Name", with: "Jester Lavore"
    fill_in "Level", with: 9
    check "Alive"
    # And I click the button "Create Child"
    click_on "Create Adventurer"
    # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
    # a new child object/row is created for that parent,
    # and I am redirected to the Parent Childs Index page where I can see the new child listed
    expect(current_path).to eq("/parties/#{party_1.id}/adventurers")
    expect(page).to have_content("Jester Lavore")
  end

  it 'User Story 14' do
    # When I visit a Child Show page
    visit "/adventurers/#{adventurer_2.id}"
    # Then I see a link to update that Child "Update Child"
    # When I click the link
    click_link "Update Adventurer"
    # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
    expect(current_path).to eq("/adventurers/#{adventurer_2.id}/edit")
    fill_in "Name", with: "Kingsley Tealeaf"
    fill_in "Level", with: 9
    check "Alive"
    # When I click the button to submit the form "Update Child"
    click_on "Update Adventurer"
    # Then a `PATCH` request is sent to '/child_table_name/:id',
    # the child's data is updated,
    # and I am redirected to the Child Show page where I see the Child's updated information
    expect(current_path).to eq("/adventurers/#{adventurer_2.id}")
    expect(page).to have_content("Kingsley Tealeaf")
  end

  it 'User Story 15' do
    # When I visit the child index
    visit '/adventurers'
    # Then I only see records where the boolean column is `true`
    expect(page).to have_no_content("Bertrand Bell")
  end
end