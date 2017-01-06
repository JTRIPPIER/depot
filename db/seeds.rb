# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

products = Product.create([
  {title: 'Milwaukee Drill Set', description: 'A set of two drills. Ideal for any DIY project', image_url:'MilwaukeeDrillSet.jpeg', price:295.00},
  {title: 'Bosch laser level', description: 'Make sure everything is level', image_url:'BoschLaserLevel.jpeg', price:35.00}
])
