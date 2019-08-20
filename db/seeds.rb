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
              weight: 30,
              xpath: '//*[@id="primaryContent"]//tbody')

Source.create(name: 'The Ringer',
              url: 'https://www.theringer.com/2019/8/5/20752394/fantasy-football-draft-rankings-top-150-standard-leagues',
              weight: 30,
              xpath: '//*[@id="content"]//h4')

Source.create(name: 'ESPN - Berry PPR',
              url: 'https://www.espn.com/fantasy/football/story/_/id/25759239/fantasy-football-2019-updated-top-200-ppr-rankings-matthew-berry',
              weight: 30,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')

Source.create(name: 'ESPN - Clay non-PPR',
              url: 'https://www.espn.com/fantasy/football/story/_/id/26692058/fantasy-football-updated-2019-non-ppr-rankings-mike-clay',
              weight: 10,
              xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')

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