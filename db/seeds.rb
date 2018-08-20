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

Source.create(name: 'ESPN',
              url: 'http://www.espn.com/fantasy/football/story/_/page/18RanksPreseason300nonPPR/2018-fantasy-football-non-ppr-rankings-top-300',
              weight: 30,
              xpath: '//aside[1]/table/tbody')

Source.create(name: 'Michael Fabiano',
              url: 'http://www.nfl.com/fantasyfootball/story/0ap3000000911798/article/top-200-fantasy-players-for-2018-michael-fabiano',
              weight: 15,
              xpath: '//*[@id="sitem-pickem-template"]')

# Source.create(name: 'Jamey Eisenberg',
#               url: 'https://www.cbssports.com/fantasy/football/rankings/',
#               weight: 7,
#               xpath: '//*[@id="page-content"]/div[1]/div[2]/div[1]/div[2]')
