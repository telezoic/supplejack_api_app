# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

default_user = SupplejackApi::User.find_or_create_by({name: 'SJ API', username: 'sjapi', email: 'info@boost.co.nz', role: 'admin'})
default_user.authentication_token = 'sjapikey'
default_user.save