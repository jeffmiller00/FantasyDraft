# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Source.create(name: 'Matthew Berry', 
              url: 'http://espn.go.com/fantasy/football/story/_/page/TMR140326/matthew-berry-2014-fantasy-football-rankings-top-200', 
              weight: 45, 
              site: 'ESPN')
Source.create(name: 'Christopher Harris', 
              url: 'http://espn.go.com/fantasy/football/story/_/id/11164366/2014-fantasy-football-top-200-rankings', 
              weight: 35, 
              site: 'ESPN')
Source.create(name: 'Eric Karabell', 
              url: 'http://espn.go.com/fantasy/football/story/_/page/KarabellTop200/karabell-2014-preseason-fantasy-football-rankings-top-200', 
              weight: 20,
              site: 'ESPN')
=begin
=end

Position.create(name: 'Quarterback', abbrev: 'QB')
Position.create(name: 'Running Back', abbrev: 'RB')
Position.create(name: 'Wide Reciever', abbrev: 'WR')
Position.create(name: 'Tight End', abbrev: 'TE')
Position.create(name: 'Kicker', abbrev: 'K')
Position.create(name: 'Defense & Special Teams', abbrev: 'DST')