# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Position.create(name: 'Quarterback', abbrev: 'QB')
Position.create(name: 'Running Back', abbrev: 'RB')
Position.create(name: 'Wide Reciever', abbrev: 'WR')
Position.create(name: 'Tight End', abbrev: 'TE')
Position.create(name: 'Kicker', abbrev: 'K')
Position.create(name: 'Defense & Special Teams', abbrev: 'DST')

Source.create(name: 'NFL.com',
              url: 'https://fantasy.nfl.com/research/rankings?leagueId=0&statType=draftStats&offset=1',
              weight: 35,
              xpath: '//*[@id="primaryContent"]//tbody')

# Source.create(name: 'NFL.com',
#               url: 'http://fantasy.nfl.com/research/rankings?leagueId=0&statType=draftStats',
#               weight: 26,
#               xpath: '//table/tbody')

# Source.create(name: 'ESPN',
#               url: 'http://www.espn.com/fantasy/football/story/_/page/18RanksPreseason300PPR/2018-fantasy-football-ppr-rankings-top-300',
#               weight: 15,
#               xpath: '//aside[1]/table/tbody[1]')

# Source.create(name: 'Tristan Cockcroft',
#               url: 'http://www.espn.com/fantasy/football/story/_/page/18RanksCockcroftPPR/tristan-h-cockcroft-2018-ppr-rankings-top-200-fantasy-football',
#               weight: 15,
#               xpath: '//aside[1]/table/tbody[1]')

# Source.create(name: 'Jamey Eisenberg',
#               url: 'https://www.cbssports.com/fantasy/football/rankings/',
#               weight: 10,
#               xpath: '//div[@class="player-wrapper"]')

# Source.create(name: 'Dave Richard',
#               url: 'https://www.cbssports.com/fantasy/football/rankings/',
#               weight: 8,
#               xpath: '//div[@class="player-wrapper"]')

# Source.create(name: 'Heath Cummings',
#               url: 'https://www.cbssports.com/fantasy/football/rankings/',
#               weight: 6,
#               xpath: '//div[@class="player-wrapper"]')