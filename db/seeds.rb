# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Source.create(name: 'Matthew Berry',
              url: 'http://www.espn.com/fantasy/football/story/_/id/14765088/matthew-berry-very-early-2016-fantasy-football-rankings-nfl',
              weight: 40,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[3]')
=begin
Source.create(name: 'Field Yates',
              url: 'http://www.espn.com/fantasy/football/story/_/id/17171463/field-yates-qb-rb-wr-te-d-st-kicker-rankings-2016-fantasy-football-nfl',
              weight: 25,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]')
=end
Source.create(name: 'Tristan H. Cockcroft',
              url: 'http://www.espn.com/fantasy/football/story/_/id/15564986/tristan-h-cockcroft-2016-fantasy-football-rankings-nfl',
              weight: 15,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]')
Source.create(name: 'Eric Karabell',
              url: 'http://www.espn.com/fantasy/football/story/_/id/15592938/eric-karabell-top-100-rankings-2016-fantasy-football-nfl',
              weight: 10,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]')
# Source.create(name: 'Mike Clay',
#               url: 'http://www.espn.com/fantasy/football/story/_/id/14472239/mike-clay-2016-fantasy-football-rankings-nfl',
#               weight: 10,
#               xpath: '')


Position.create(name: 'Quarterback', abbrev: 'QB')
Position.create(name: 'Running Back', abbrev: 'RB')
Position.create(name: 'Wide Reciever', abbrev: 'WR')
Position.create(name: 'Tight End', abbrev: 'TE')
Position.create(name: 'Kicker', abbrev: 'K')
Position.create(name: 'Defense & Special Teams', abbrev: 'DST')