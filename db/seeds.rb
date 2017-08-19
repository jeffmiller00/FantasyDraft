# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Source.create(name: 'Matthew Berry',
              url: 'http://www.espn.com/fantasy/football/story/_/page/17RanksPreseason200nonPPR/2017-fantasy-football-standard-rankings-non-ppr-top-200?mb',
              weight: 30,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
Source.create(name: 'Field Yates',
              url: 'http://www.espn.com/fantasy/football/story/_/page/17RanksPreseason200nonPPR/2017-fantasy-football-standard-rankings-non-ppr-top-200?fy',
              weight: 15,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
Source.create(name: 'Mike Clay',
              url: 'http://www.espn.com/fantasy/football/story/_/page/17RanksPreseason200nonPPR/2017-fantasy-football-standard-rankings-non-ppr-top-200?mc',
              weight: 7,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
Source.create(name: 'Tristan H. Cockcroft',
              url: 'http://www.espn.com/fantasy/football/story/_/page/17RanksPreseason200nonPPR/2017-fantasy-football-standard-rankings-non-ppr-top-200?tc',
              weight: 14,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
Source.create(name: 'Eric Karabell',
              url: 'http://www.espn.com/fantasy/football/story/_/page/17RanksPreseason200nonPPR/2017-fantasy-football-standard-rankings-non-ppr-top-200?ek',
              weight: 14,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
Source.create(name: 'NFL.com',
              url: 'http://fantasy.nfl.com/research/rankings?leagueId=0&statType=draftStats',
              weight: 20,
              xpath: '//*[tbody]')


Position.create(name: 'Quarterback', abbrev: 'QB')
Position.create(name: 'Running Back', abbrev: 'RB')
Position.create(name: 'Wide Reciever', abbrev: 'WR')
Position.create(name: 'Tight End', abbrev: 'TE')
Position.create(name: 'Kicker', abbrev: 'K')
Position.create(name: 'Defense & Special Teams', abbrev: 'DST')