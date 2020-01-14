# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Cat.destroy_all
CatRentalRequest.destroy_all


c1 = Cat.create!(color:"gray", birth_date: "20/12/2015", name: "felix", sex: 'M' )
c2 = Cat.create!(color:"black", birth_date: "12/02/2014", name: "GiGi", sex: 'F' )
c3 = Cat.create!(color:"white", birth_date: "01/05/2012", name: "Whiskers", sex: 'M' )
c4 = Cat.create!(color:"orange", birth_date: "08/01/1994", name: "Kitten", sex: 'F' )
c5 = Cat.create!(color:"gray", birth_date: "02/03/2013", name: "Duke", sex: 'M' )
c6 = Cat.create!(color:"black", birth_date: "04/08/2011", name: "Buhbay", sex: 'F' )



r1 = CatRentalRequest.create!(cat_id: c2.id, start_date: "4/10/2019", end_date:"7/10/2019", status: 'APPROVED')
r2 = CatRentalRequest.create!(cat_id: c2.id, start_date: "8/10/2019", end_date:"11/10/2019")
r3 = CatRentalRequest.create!(cat_id: c2.id, start_date: "12/10/2019", end_date:"15/10/2019")
