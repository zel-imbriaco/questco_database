require 'rails_helper'

RSpec.describe '/parties endpoint', type: :feature do

  party_1 = Party.create(name: "The Mighty Nein", rank: 1, active: true)
  party_2 = Party.create(name: "Bell's Helles", rank: 2, active: false)
  party_3 = Party.create(name: "The Answer", rank: 4, active: true)
  adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_1.id)
  adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_1.id)
  adventurer_3 = Adventurer.create(name: "Lucien", level: 9, alive: true, party_id: party_1.id)

  it 'User Story 1' do

    # When I visit '/parents'
    visit '/parties'
    # Then I see the name of each parent record in the system
    expect(page).to have_content(party_2.name)
    expect(page).to have_content(party_1.name)
  end

  it 'User Story 2' do

    # When I visit '/parents/:id'
    visit "/parties/#{party_1.id}"
    # Then I see the parent with that id including the parent's attributes:
    # - data from each column that is on the parent table
    expect(page).to have_content(party_1.name)
    expect(page).to have_content(party_1.rank)
    expect(page).to have_content(party_1.active)
  end

  it 'User Story 5' do

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

    # When I visit the parent index,
    visit '/parties'
    # I see that records are ordered by most recently created first
    expect(page.text.index(party_2.name)).to be < page.text.index(party_1.name)
    # And next to each of the records I see when it was created
    expect(page).to have_content(party_1.created_at)
    expect(page).to have_content(party_2.created_at)
  end

  it 'User Story 7' do

    # When I visit a parent's show page
    visit "/parties/#{party_1.id}"
    # I see a count of the number of children associated with this parent
    expect(page).to have_content("Adventurer Count: 3")
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

    # When I visit a parent show page ('/parents/:id')
    visit "/parties/#{party_1.id}"
    # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
    expect(page).to have_link("Link", href: "/parties/#{party_1.id}/adventurers")
  end

  it 'User Story 11' do
    # When I visit the Parent Index page
    visit "/parties"
    # Then I see a link to create a new Parent record, "New Parent"
    # When I click this link
    click_link "New Party"
    # Then I am taken to '/parents/new' where I  see a form for a new parent record
    expect(current_path).to eq("/parties/new")
    # When I fill out the form with a new parent's attributes:
    fill_in 'Name', with: 'Something New'
    fill_in 'Rank', with: '7'
    check 'Active'
    # And I click the button "Create Parent" to submit the form
    click_on 'Create Party'
    # Then a `POST` request is sent to the '/parents' route,
    # a new parent record is created,
    # and I am redirected to the Parent Index page where I see the new Parent displayed.
    expect(current_path).to eq("/parties")
    expect(page).to have_content("The Answer")
  end

  it 'User Story 12' do
    # When I visit a parent show page
    visit "/parties/#{party_3.id}"
    # Then I see a link to update the parent "Update Parent"
    # When I click the link "Update Parent"
    click_link "Edit Party Info"
    # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
    expect(current_path).to eq("/parties/#{party_3.id}/edit")
    # When I fill out the form with updated information
    fill_in 'Name', with: "The Kings' Guard"
    # And I click the button to submit the form
    click_on 'Update Party'
    # Then a `PATCH` request is sent to '/parents/:id',
    # the parent's info is updated,
    # and I am redirected to the Parent's Show page where I see the parent's updated info
    expect(current_path).to eq("/parties/#{party_3.id}")
    expect(page).to have_content("The Kings' Guard")
  end

  it 'User Story 16' do
    # When I visit the Parent's children Index Page
    visit "/parties/#{party_1.id}/adventurers"
    # Then I see a link to sort children in alphabetical order
    expect(page).to have_link("Sort Adventurers")
    # When I click on the link
    click_link "Sort Adventurers"
    # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
    expect(current_path).to eq("/parties/#{party_1.id}/adventurers")
    expect(page.text.index(adventurer_2.name)).to be > page.text.index(adventurer_3.name)
  end

  it 'User Story 17' do
    # When I visit the parent index page
    visit '/parties'
    # Next to every parent, I see a link to edit that parent's info
    expect(page).to have_link(nil, href: "/parties/#{party_1.id}/edit")
    expect(page).to have_link(nil, href: "/parties/#{party_2.id}/edit")
    expect(page).to have_link(nil, href: "/parties/#{party_3.id}/edit")
    # When I click the link
    click_link "Edit Party", href: "/parties/#{party_1.id}/edit" 
    # I should be taken to that parents edit page where I can update its information just like in User Story 4
    expect(current_path).to eq("/parties/#{party_1.id}/edit")
    expect(page).to have_button("Update Party")
  end

  it 'User Story 18' do
    # When I visit the `child_table_name` index page or a parent `child_table_name` index page
    visit "/parties/#{party_1.id}/adventurers"
    # Next to every child, I see a link to edit that child's info
    expect(page).to have_link(nil, href: "/adventurers/#{adventurer_1.id}/edit")
    expect(page).to have_link(nil, href: "/adventurers/#{adventurer_2.id}/edit")
    expect(page).to have_link(nil, href: "/adventurers/#{adventurer_3.id}/edit")
    # When I click the link
    click_link "Edit Adventurer", href: "/adventurers/#{adventurer_2.id}/edit"
    # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 11
    expect(current_path).to eq("/adventurers/#{adventurer_2.id}/edit")
    expect(page).to have_button("Update Adventurer")
  end

  it 'User Story 19' do
    # When I visit a parent show page
    visit "/parties/#{party_1.id}"
    # Then I see a link to delete the parent
    expect(page).to have_link("Delete Party")
    # When I click the link "Delete Parent"
    click_link "Delete Party"
    # Then a 'DELETE' request is sent to '/parents/:id',
    # the parent is deleted, and all child records are deleted
    # and I am redirected to the parent index page where I no longer see this parent
    expect(current_path).to eq("/parties")
    expect(page).to have_no_content("The Mighty Nein")
  end
end