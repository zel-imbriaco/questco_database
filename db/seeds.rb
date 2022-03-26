# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Party.destroy_all

sleep(1)

party_1 = Party.create(name: "Vox Machina", rank: 1, active: true)
party_2 = Party.create(name: "The Mighty Nein", rank: 2, active: true)
party_3 = Party.create(name: "Bell's Helles", rank: 3, active: true)