# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user = User.create 	:username => 'Chloe',
					:email => 'chloe.moulin42@free.fr',
					:role => 'admin',
					:password => 'chocolat42230',
					:password_confirmation => 'chocolat42230',
					:hashed_password => 'da7d8268a344f696064f5db974c02ef4d51327b0'