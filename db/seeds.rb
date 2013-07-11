require 'yaml'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the seed data




# Activiyt States
seed = YAML::load_file('db/seeds/activity_states.yaml')
seed.each_pair do |key,type|  
	print "#{key}, #{type}\n"
	type_object = ActivityState.find_or_create_by_name type['name']
	type_object.thumbnail = type['thumbnail']
	type_object.save
end  








