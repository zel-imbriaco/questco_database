# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Party.destroy_all
Adventurer.destroy_all

sleep(1)

party_1 = Party.create(name: "Vox Machina", rank: 1, active: true)
party_2 = Party.create(name: "The Mighty Nein", rank: 2, active: true)
party_3 = Party.create(name: "Bell's Helles", rank: 3, active: true)

adventurer_1 = Adventurer.create(name: "Beauregard Lionett", level: 9, alive: true, party_id: party_2.id)
adventurer_2 = Adventurer.create(name: "Mollymauk Tealeaf", level: 5, alive: false, party_id: party_2.id)
adventurer_3 = Adventurer.create(name: "Fresh Cut Grass", level: 6, alive: true, party_id: party_3.id)
adventurer_4 = Adventurer.create(name: "Vex'ahlia", level: 17, alive: true, party_id: party_1.id)
adventurer_5 = Adventurer.create(name: "Vax'ildan", level: 17, alive: false, party_id: party_1.id)