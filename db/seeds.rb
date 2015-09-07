# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Source.create(name: 'Matthew Berry',
              url: 'http://espn.go.com/fantasy/football/story/_/page/BerryRanks150311/matthew-berry-2015-fantasy-football-rankings',
              weight: 41,
              site: 'ESPN')
Source.create(name: 'Field Yates',
              url: 'http://espn.go.com/fantasy/football/story/_/page/Yatesranks2015/field-yates-2015-fantasy-football-rankings',
              weight: 25,
              site: 'ESPN')
Source.create(name: 'Tristan H. Cockcroft',
              url: 'http://espn.go.com/fantasy/football/story/_/id/12880160/tristan-h-cockcroft-2015-fantasy-football-rankings',
              weight: 17,
              site: 'ESPN')
Source.create(name: 'Eric Karabell',
              url: 'http://espn.go.com/fantasy/football/story/_/page/Karabellranks150311/eric-karabell-2015-fantasy-football-rankings',
              weight: 17,
              site: 'ESPN')

Position.create(name: 'Quarterback', abbrev: 'QB')
Position.create(name: 'Running Back', abbrev: 'RB')
Position.create(name: 'Wide Reciever', abbrev: 'WR')
Position.create(name: 'Tight End', abbrev: 'TE')
Position.create(name: 'Kicker', abbrev: 'K')
Position.create(name: 'Defense & Special Teams', abbrev: 'DST')