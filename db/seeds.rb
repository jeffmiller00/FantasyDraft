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
              weight: 10,
              xpath: '//tbody')

Source.create(name: 'The Ringer',
              url: 'https://fantasyfootball.theringer.com',
              weight: 25,
              xpath: '//*[@id="__NEXT_DATA__"]')

Source.create(name: 'FF Calc',
              url: 'https://fantasyfootballcalculator.com/rankings/standard',
              weight: 40,
              xpath: '//*[@id="kt_content"]/div[2]/div/div[1]/div[2]/table/tbody')

Source.create(name: 'Fantasy Pros',
              url: 'https://www.fantasypros.com/nfl/rankings/consensus-cheatsheets.php',
              weight: 25,
              xpath: '//script[7]')

# Source.create(name: 'ESPN - Berry PPR',
#               url: 'https://www.espn.com/fantasy/football/story/_/id/25759239/fantasy-football-2019-updated-top-200-ppr-rankings-matthew-berry',
#               weight: 20,
#               xpath: '//*[@id="article-feed"]/article[1]/div/div[2]/aside[2]/table/tbody')
