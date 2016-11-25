# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#homes = Home.create([{address: 'Vienna' }, { address: 'Fairfax' }, { address: 'Leesburg' }])
homes = Home.create([{address: 'Vienna', rating: 5 }, { address: 'Fairfax', rating: 4 }, { address: 'Leesburg', rating: 3 }])

Home.create(title: 'House 1', address: 'McLean', rating: 5)
Home.create(title: 'House 2', address: 'Ashburn', rating: 4)
Home.create(title: 'House 3', address: 'Fairfax', rating: 2)