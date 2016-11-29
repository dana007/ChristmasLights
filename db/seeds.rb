# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


#homes = Home.create([{address: 'Vienna' }, { address: 'Fairfax' }, { address: 'Leesburg' }])
# homes = Home.create([{title: 'House 4',  state: 'VA', city: 'Vienna', rating: 5 },
# {title: 'House 5',  state: 'VA',city: 'Fairfax', rating: 2 }, {title: 'House 6',  state: 'MD', city: 'Chevy Chase', rating: 4 }])

Home.create(title: 'House 1', street_address: "1234 Main St.", city: 'McLean', state: 'MD', zip_code: '12345', rating: 5)
Home.create(title: 'House 2', street_address: "5678 Main St.", city: 'Ashburn', state: 'VA', zip_code: '12345', rating: 4)
Home.create(title: 'House 3', street_address: "007 Bond St.", city: 'Fairfax', state: 'VA', zip_code: '12345', rating: 2)

Comment.create(home_id: '30', content: 'First comment for home_id =12')
Comment.create(home_id: '30', content: 'Another comment for home_id =12')
Comment.create(home_id: '30', content: 'Last comment for home_id =12')

Comment.create(home_id: '29', content: 'Test comment for home_id =11')
Comment.create(home_id: '29', content: 'Another test comment for home_id =11')

Comment.create(home_id: '28', content: 'Random comment for home_id =10')
Comment.create(home_id: '28', content: 'The comment for home_id =10')