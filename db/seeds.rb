# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#homes = Home.create([{address: 'Vienna' }, { address: 'Fairfax' }, { address: 'Leesburg' }])
homes = Home.create([{title: 'House 4',  state: 'VA', city: 'Vienna', rating: 5 }, 
{title: 'House 5',  state: 'VA',city: 'Fairfax', rating: 2 }, {title: 'House 6',  state: 'MD', city: 'Chevy Chase', rating: 4 }])

#Home.create(title: 'House 1', state: 'VA', city: 'McLean', rating: 5)
#Home.create(title: 'House 2', state: 'MD',city: 'Chevy Chase', rating: 4)
#Home.create(title: 'House 3', state: 'VA',city: 'Fairfax', rating: 3)